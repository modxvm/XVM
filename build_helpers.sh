#!/usr/bin/env bash
# XVM — Bash Build Helpers
#
# Reusable shell functions for AS3 compilation, SWF/SWC patching,
# Python compilation, and .wotmod packaging.
#
# Called by build.py via:  bash build_helpers.sh <command> [args...]
#
# Each function accepts named arguments (--key value) so the interface
# is self-documenting and order-independent.

set -euo pipefail


# ============================================================================
# build_swc — compile an AS3 SWC via Apache Royale (compc)
# ============================================================================
#
# Args:
#   --name              Build artifact name (for logging)
#   --output            Output .swc path
#   --include-classes   Space-separated class names (may contain $AppLinks)
#   --source-path       Comma-separated source directories
#   --external-library-path  Comma-separated .swc paths
#   --include-libraries Comma-separated .swc paths (optional)
#   --royale-home       Royale SDK root
#   --config            Royale config XML path
#   --flavor            wg or lesta
#
build_swc() {
    local name="" output="" include_classes="" source_path="" ext_libs="" inc_libs=""
    local royale_home="" config="" flavor=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --name)              name="$2"; shift 2 ;;
            --output)            output="$2"; shift 2 ;;
            --include-classes)   include_classes="$2"; shift 2 ;;
            --source-path)       source_path="$2"; shift 2 ;;
            --external-library-path) ext_libs="$2"; shift 2 ;;
            --include-libraries) inc_libs="$2"; shift 2 ;;
            --royale-home)       royale_home="$2"; shift 2 ;;
            --config)            config="$2"; shift 2 ;;
            --flavor)            flavor="$2"; shift 2 ;;
            *) echo "build_swc: unknown arg: $1" >&2; exit 1 ;;
        esac
    done

    local is_wg=false is_lesta=false
    [[ "$flavor" == "wg" ]] && is_wg=true
    [[ "$flavor" == "lesta" ]] && is_lesta=true

    mkdir -p "$(dirname "$output")"

    echo "    [SWC] $name"

    local -a args=()

    # include-classes (space-separated, may contain $AppLinks)
    if [[ -n "$include_classes" ]]; then
        # Word-split on spaces to produce separate arguments
        # shellcheck disable=SC2086
        args+=("-include-classes" $include_classes)
    fi

    # source-path (comma-separated → multiple -source-path flags)
    if [[ -n "$source_path" ]]; then
        local first=true
        IFS=',' read -ra sp_arr <<< "$source_path"
        for sp in "${sp_arr[@]}"; do
            [[ -z "$sp" ]] && continue
            if $first; then
                args+=("-source-path=$sp")
                first=false
            else
                args+=("-source-path+=$sp")
            fi
        done
    fi

    # external-library-path
    if [[ -n "$ext_libs" ]]; then
        args+=("-external-library-path+=$ext_libs")
    fi

    # include-libraries
    if [[ -n "$inc_libs" ]]; then
        args+=("-include-libraries+=$inc_libs")
    fi

    java \
        -Dsun.io.useCanonCaches=false -Xms32m -Xmx512m \
        "-Droyalelib=$royale_home/frameworks" \
        -jar "$royale_home/js/lib/compc.jar" \
        -targets=SWF \
        "-define+=CLIENT::LESTA,$is_lesta" \
        "-define+=CLIENT::WG,$is_wg" \
        -target-player=10.2 \
        -swf-version=11 \
        "-load-config=$config" \
        -output "$output" \
        "${args[@]}"
}


# ============================================================================
# build_swf — compile an AS3 SWF via Apache Royale (mxmlc)
# ============================================================================
#
# Args: same as build_swc, plus:
#   --target    AS3 entry-point file
#
build_swf() {
    local name="" output="" target="" source_path="" ext_libs="" inc_libs=""
    local royale_home="" config="" flavor=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --name)              name="$2"; shift 2 ;;
            --output)            output="$2"; shift 2 ;;
            --target)            target="$2"; shift 2 ;;
            --source-path)       source_path="$2"; shift 2 ;;
            --external-library-path) ext_libs="$2"; shift 2 ;;
            --include-libraries) inc_libs="$2"; shift 2 ;;
            --royale-home)       royale_home="$2"; shift 2 ;;
            --config)            config="$2"; shift 2 ;;
            --flavor)            flavor="$2"; shift 2 ;;
            *) echo "build_swf: unknown arg: $1" >&2; exit 1 ;;
        esac
    done

    local is_wg=false is_lesta=false
    [[ "$flavor" == "wg" ]] && is_wg=true
    [[ "$flavor" == "lesta" ]] && is_lesta=true

    mkdir -p "$(dirname "$output")"

    echo "    [SWF] $name"

    local -a args=()

    # source-path
    if [[ -n "$source_path" ]]; then
        local first=true
        IFS=',' read -ra sp_arr <<< "$source_path"
        for sp in "${sp_arr[@]}"; do
            [[ -z "$sp" ]] && continue
            if $first; then
                args+=("-source-path=$sp")
                first=false
            else
                args+=("-source-path+=$sp")
            fi
        done
    fi

    if [[ -n "$ext_libs" ]]; then
        args+=("-external-library-path+=$ext_libs")
    fi
    if [[ -n "$inc_libs" ]]; then
        args+=("-include-libraries+=$inc_libs")
    fi

    java \
        -Dsun.io.useCanonCaches=false -Xms32m -Xmx512m \
        "-Droyalelib=$royale_home/frameworks" \
        -jar "$royale_home/js/lib/mxmlc.jar" \
        -targets=SWF \
        "-define+=CLIENT::LESTA,$is_lesta" \
        "-define+=CLIENT::WG,$is_wg" \
        -target-player=10.2 \
        -swf-version=11 \
        "-load-config=$config" \
        -output "$output" \
        "${args[@]}" \
        "$target"
}


# ============================================================================
# patch_swc — rabcdasm pipeline for SWC post-build patching
# ============================================================================
#
# Args:
#   --swc-file      Path to the .swc to patch (modified in-place)
#   --patches       Comma-separated patch file paths
#   --rabcdasm-dir  Directory containing rabcdasm binaries
#
patch_swc() {
    local swc_file="" patches="" rabcdasm_dir=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --swc-file)     swc_file="$2"; shift 2 ;;
            --patches)      patches="$2"; shift 2 ;;
            --rabcdasm-dir) rabcdasm_dir="$2"; shift 2 ;;
            *) echo "patch_swc: unknown arg: $1" >&2; exit 1 ;;
        esac
    done

    echo "    [SWC-PATCH] $(basename "$swc_file")"

    local work_dir
    work_dir="$(mktemp -d)"

    unzip -q "$swc_file" -d "$work_dir"

    local lib_swf="$work_dir/library.swf"
    "$rabcdasm_dir/abcexport" "$lib_swf"
    "$rabcdasm_dir/rabcdasm" "$work_dir/library-0.abc"

    local dasm_dir="$work_dir/library-0"
    IFS=',' read -ra patch_arr <<< "$patches"
    for pf in "${patch_arr[@]}"; do
        [[ -z "$pf" || ! -f "$pf" ]] && continue
        echo "      patch: $(basename "$pf")"
        (cd "$dasm_dir" && patch --binary -p1 -i "$pf")
    done

    "$rabcdasm_dir/rabcasm" "$dasm_dir/library-0.main.asasm"
    "$rabcdasm_dir/abcreplace" "$lib_swf" 0 "$dasm_dir/library-0.main.abc"

    # Repack SWC
    rm "$swc_file"
    (cd "$work_dir" && zip -q "$swc_file" library.swf catalog.xml)
    rm -rf "$work_dir"
}


# ============================================================================
# patch_wg_swf — rabcdasm pipeline for WG/Lesta SWF patching
# ============================================================================
#
# Args:
#   --input-swf     Source SWF (from game client)
#   --output-swf    Patched output SWF path
#   --patches       Comma-separated patch file paths (may be empty)
#   --linkages      Comma-separated linkage names (may be empty)
#   --rabcdasm-dir  Directory containing rabcdasm binaries
#
patch_wg_swf() {
    local input_swf="" output_swf="" patches="" linkages="" rabcdasm_dir=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --input-swf)    input_swf="$2"; shift 2 ;;
            --output-swf)   output_swf="$2"; shift 2 ;;
            --patches)      patches="$2"; shift 2 ;;
            --linkages)     linkages="$2"; shift 2 ;;
            --rabcdasm-dir) rabcdasm_dir="$2"; shift 2 ;;
            *) echo "patch_wg_swf: unknown arg: $1" >&2; exit 1 ;;
        esac
    done

    if [[ -z "$patches" && -z "$linkages" ]]; then
        mkdir -p "$(dirname "$output_swf")"
        cp "$input_swf" "$output_swf"
        return 0
    fi

    echo "    [SWF-PATCH] $(basename "$input_swf")"

    local work_dir
    work_dir="$(mktemp -d)"
    local base
    base="$(basename "$input_swf" .swf)"

    cp "$input_swf" "$work_dir/${base}.swf"
    local work_swf="$work_dir/${base}.swf"

    # Disassemble
    "$rabcdasm_dir/abcexport" "$work_swf"
    "$rabcdasm_dir/rabcdasm" "$work_dir/${base}-0.abc"

    local dasm_dir="$work_dir/${base}-0"

    # Apply patches
    if [[ -n "$patches" ]]; then
        IFS=',' read -ra patch_arr <<< "$patches"
        for pf in "${patch_arr[@]}"; do
            [[ -z "$pf" || ! -f "$pf" ]] && continue
            echo "      patch: $(basename "$pf")"
            (cd "$dasm_dir" && patch --binary -p1 -i "$pf")
        done
    fi

    # Apply linkage conversions (trait const → trait slot)
    if [[ -n "$linkages" ]]; then
        local linkage_file="$dasm_dir/net/wg/data/constants/Linkages.class.asasm"
        if [[ -f "$linkage_file" ]]; then
            IFS=',' read -ra link_arr <<< "$linkages"
            for lname in "${link_arr[@]}"; do
                [[ -z "$lname" ]] && continue
                if grep -q "trait const.*\"$lname\"" "$linkage_file"; then
                    sed -i "s/trait const \(QName(PackageNamespace(\"\"), \"$lname\")\)/trait slot \1/" "$linkage_file"
                    echo "      linkage: $lname -> slot"
                else
                    echo "      linkage: $lname (not found, skipping)"
                fi
            done
        fi
    fi

    # Reassemble
    "$rabcdasm_dir/rabcasm" "$dasm_dir/${base}-0.main.asasm"
    "$rabcdasm_dir/abcreplace" "$work_swf" 0 "$dasm_dir/${base}-0.main.abc"

    mkdir -p "$(dirname "$output_swf")"
    cp "$work_swf" "$output_swf"
    rm -rf "$work_dir"
}


# ============================================================================
# compile_python_dir — compile .py files to .pyc via Python 2.7
# ============================================================================
#
# Args:
#   --src-dir   Source directory containing .py files
#   --dst-dir   Destination directory for .pyc files
#   --python27  Path to Python 2.7 interpreter
#
compile_python_dir() {
    local src_dir="" dst_dir="" python27=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --src-dir)  src_dir="$2"; shift 2 ;;
            --dst-dir)  dst_dir="$2"; shift 2 ;;
            --python27) python27="$2"; shift 2 ;;
            *) echo "compile_python_dir: unknown arg: $1" >&2; exit 1 ;;
        esac
    done

    mkdir -p "$dst_dir"
    local count=0

    while IFS= read -r -d '' pyfile; do
        local rel="${pyfile#$src_dir/}"
        local out_sub
        out_sub="$(dirname "$rel")"
        local target_dir="$dst_dir"
        [[ "$out_sub" != "." ]] && target_dir="$dst_dir/$out_sub"
        mkdir -p "$target_dir"

        "$python27" -m py_compile "$pyfile"
        mv "${pyfile}c" "$target_dir/"
        count=$((count + 1))
    done < <(find "$src_dir" -name "*.py" -print0)

    echo "      $count .pyc files"
}


# ============================================================================
# package_wotmod — zip a staging directory into a .wotmod/.mtmod
# ============================================================================
#
# Args:
#   --staging-dir  Directory containing meta.xml + res/ tree
#   --output-file  Output .wotmod or .mtmod path
#
package_wotmod() {
    local staging_dir="" output_file=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --staging-dir) staging_dir="$2"; shift 2 ;;
            --output-file) output_file="$2"; shift 2 ;;
            *) echo "package_wotmod: unknown arg: $1" >&2; exit 1 ;;
        esac
    done

    mkdir -p "$(dirname "$output_file")"
    (cd "$staging_dir" && zip -0 -X -r "$output_file" .)
}


# ============================================================================
# Dispatch
# ============================================================================

cmd="${1:-}"
[[ -z "$cmd" ]] && { echo "Usage: bash build_helpers.sh <command> [args...]" >&2; exit 1; }
shift

case "$cmd" in
    build_swc)          build_swc "$@" ;;
    build_swf)          build_swf "$@" ;;
    patch_swc)          patch_swc "$@" ;;
    patch_wg_swf)       patch_wg_swf "$@" ;;
    compile_python_dir) compile_python_dir "$@" ;;
    package_wotmod)     package_wotmod "$@" ;;
    *) echo "Unknown command: $cmd" >&2; exit 1 ;;
esac
