<?=r $self->render('inc/header') ?>

<div id="main">
<div id="formBox">
<h2>否めないコメントをつけたいキーワードを入力してください。</h2>
<p>例：窪塚洋介、草なぎ剛、ドッペルゲンガー</p>

<form method="get" action="/search" id="search_box">
  <input name="q" type="text" id="formTxt" />
  <input type="image" src="/img/btn_search.png" alt="検索" width="135" height="70" class="btn" />
</form>
<!--/#formBox--></div>


? if ($s->{form}->has_error) {
<ul class="error">
? for my $msg ( $s->{form}->get_error_messages) {
    <li><?= $msg ?></li>
? }
</ul>
? }

<div class="subCont" id="list">
<h2><img src="/img/tit2.png" alt="いなめなリスト" width="950" height="40" /></h2>
<div class="ad" id="ad2"><!--/adsence-->ここにアドセンスはいる</div>
<p>総キーワード：<strong>20</strong>件 / 総コメント：<strong>25</strong>件</p>


<div id="listBox">
<ul>
<li class="lvl1"><a href="#">安達祐実 (35)</a></li>
<li class="lvl2"><a href="#">天海祐希 (35)</a></li>
<li class="lvl3"><a href="#">有坂来瞳 (35)</a></li>
<li class="lvl4"><a href="#">飯島愛 (35)</a></li>
<li class="lvl5"><a href="#">池脇千鶴 (35)</a></li>
<li class="lvl6"><a href="#">江角マキコ (35)</a></li>
<li class="lvl7"><a href="#">榎本加奈子 (35)</a></li>
<li class="lvl1"><a href="#">有森也実 (35)</a></li>
<li class="lvl2"><a href="#">いとうまい子 (35)</a></li>
<li class="lvl3"><a href="#">井上真央 (35)</a></li>
<li class="lvl4"><a href="#">上野樹里 (35)</a></li>
</ul>

<!--/#list--></div>

</div>


<div class="ad" id="ad3"><!--/adsence-->ここにアドセンスはいる</div>

<p class="goPageTop"><a href="#top">ページトップへ</a></p>
<!--/#main--></div>
<hr />

<?=r $self->render('inc/footer') ?>

