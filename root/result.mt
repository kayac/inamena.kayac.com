? my $result  = $c->stash->{result};
? my $keyword = $c->stash->{keyword};

? extends 'common/base'

? block title => html($result->{title} . 'の否めないエピソード | ');

? block content => sub {

<div id="main">
<div id="formBox">
<h2>否めないコメントをつけたいキーワードを入力してください。</h2>
<p>例：窪塚洋介、草なぎ剛、ドッペルゲンガー</p>

<form id="form" method="post" action="<?= $c->uri_for('/') ?>">
  <input id="formTxt" name="q" type="text" value="<?= $result->{title} ?>" />
  <input type="image" src="<?= $c->uri_for('/img/btn_search.png') ?>" alt="検索" width="135" height="70" class="btn" />
</form>
<!--/#formBox--></div>

<div class="subCont" id="detail">
<h2><img src="/img/tit1.png" alt="検索結果" width="950" height="40" /></h2>

<ul class="blogTag">
  <li>
    <img src="/img/subtit_blog.png" alt="この結果をブログに張る" width="167" height="14" />
    <input type="text" value="<?= $c->stash->{link} ?>" />
  </li>
</ul>

<div id="detailBox">
<h2><?= $result->{title} ?></h2>

<p><?= raw_string $result->{body} ?></p>

? if ($keyword and $keyword->comments->count) {
<p class="but">…しかし、</p>
<ul id="episode">
? for my $comment ($keyword->comments) {
  <li><?= $comment->body ?></li>
? }
</ul>
<p class="but">ことは否めない。</p>
? }
<!--/#detailBox--></div>

<ul class="blogTag">
  <li>
    <img src="/img/subtit_blog.png" alt="この結果をブログに張る" width="167" height="14" />
    <input type="text" value="<?= $c->stash->{link} ?>" />
  </li>
</ul>

<div id="addEpisode">
<h3><img src="/img/subtit_comment.png" alt="否めないコメントをつける" width="189" height="15" /></h3>

<form method="post">
<p>…しかし、<?= raw_string form->input('comment') ?>
  <input name="imageField" type="image" src="/img/btn_comment.png" alt="ことは否めない。" class="btn" width="196" height="50" /></p>

<!--/addEpisode--></div>

<!--/#detail--></div>


<div class="ad" id="ad3">
?= $self->render('common/adsense')
<!--/adsence--></div>


<div id="amazon">

<h2>“<strong><?= $result->{title} ?></strong>”に関連があるということは否めないアイテム</h2>

? my $i = 0;
? for my $item (@{ $c->stash->{asamasi} || [] }) {
<div class="amazonBox<?= $i++%3 == 0 ? ' first' : '' ?>">
<ul class="amazonImage">
  <li>
    <a href="<?= $item->{link} ?>" class="external">
      <img src="<?= $item->{image} || $c->uri_for('/img/comingsoon_books.gif') ?>" alt="<?= $item->{title} ?>" /></a>
  </li>
</ul>
<h3><a href="<?= $item->{link} ?>" class="external"><?= $item->{title} ?></a></h3>
<h4><?= $item->{author} || $item->{manufacturer} ?></h4>
<p>価格：  	<strong><?= $item->{price} ?></strong></p>
<!--/amazonBox--></div>
? }
<!--/amazon--></div>


<p class="goPageTop"><a href="#top">ページトップへ</a></p>
<!--/#main--></div>
<hr />

? } # endblock content

