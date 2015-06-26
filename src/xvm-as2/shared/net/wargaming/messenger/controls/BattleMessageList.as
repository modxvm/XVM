intrinsic class net.wargaming.messenger.controls.BattleMessageList extends net.wargaming.notification.FadingMessageList
{
	public var _renderers : Object;

	public function BattleMessageList();

	public function handleInput(details, pathToFocus);

	public function updateHistoryState(value);

	public function halfHideLastMessage(countMessages, alphaLastMessage, isHistoryMessage);

	public function updateLastHistoryRenderer(countMessagesOfHistory, currentAlphaForLstMessage);

	public function pushLatestMessages(initData, lifeTimeRecoveredMessages, alphaSpeed, showAlpha);

	public function pushHistoryMessage(messageData, countOfHistoryMessages, idxMessage, historyCount, isUpEnabled, alphaLastMessage);

	public function updateRendererBg(messageData, renderer);

	public function listingMessageHistory(totalCountMessage, hideFirstMessage, alpha, needValidation);

	public function updateLast(renderer, alpha);

	public function removePreLastRenderer(countMessagesOfHistory);

}