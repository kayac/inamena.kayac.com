? my $result = $c->stash->{result};

? extends 'common/base'

? block title => html($result->{title} . 'の否めないエピソード | ');

? block content => sub {

<div id="main">
<div id="formBox">
<h2>否めないコメントをつけたいキーワードを入力してください。</h2>
<p>例：窪塚洋介、草なぎ剛、ドッペルゲンガー</p>

<form method="post" action="<?= $c->uri_for('/') ?>">
  <input id="formTxt" name="q" type="text" value="<?= $result->{title} ?>" />
  <img src="<?= $c->uri_for('/img/btn_search.png') ?>" alt="検索"  width="135" height="70" class="btn" onclick="$('form').submit()" />
</form>
<!--/#formBox--></div>

<div class="subCont" id="detail">
<h2><img src="/img/tit1.png" alt="検索結果" width="950" height="40" /></h2>
<div class="ad" id="ad2"><!--/adsence-->ここにアドセンスはいる</div>
<ul class="blogTag">
  <li>
    <img src="/img/subtit_blog.png" alt="この結果をブログに張る" width="167" height="14" />
    <input type="text" value="<?= $c->stash->{link} ?>" />
  </li>
</ul>

<div id="detailBox">
<h2><?= $result->{title} ?></h2>

<p><?= raw_string $result->{body} ?></p>

<p class="but">…しかし、</p>
<ul id="episode"><li></li><li>天才の性なのか最近奇行が多い気がする</li><li>最近愛国者代表のようになっている</li></ul>
<p class="but">ことは否めない。</p>

<!--/#detailBox--></div>


<ul class="blogTag"><li><img src="/img/subtit_blog.png" alt="この結果をブログに張る" width="167" height="14" /><input type="text" value="&lt;a href=&quot;&quot; target=&quot;_blank&quot;&gt;イチローの否めないエピソード【いなめなヶ崎】&lt;/a&gt;" /></li>
</ul>

<div id="addEpisode">
<h3><img src="/img/subtit_comment.png" alt="否めないコメントをつける" width="189" height="15" /></h3>
<p>…しかし、<input name="" type="text" id="addEpisodeTxt" /><input name="imageField" type="image" src="/img/btn_comment.png" alt="ことは否めない。" class="btn" width="196" height="50" /></p>
<!--/addEpisode--></div>

<!--/#detail--></div>


<div class="ad" id="ad3"><!--/adsence-->ここにアドセンスはいる</div>


<div id="amazon">

<h2>“<strong>イチロー</strong>”に関連があるということは否めないアイテム</h2>

<div class="amazonBox first">
<ul class="amazonImage"><li><a href="アマゾンリンク" class="external"><img src="" alt="商品名" width="150" height="150" /></a></li>
</ul>
<h3><a href="アマゾンリンク" class="external">商品名</a></h3>
<h4>著者名とか製造元名</h4>
<p>価格：  	<strong>￥ 12,210 </strong></p>
<!--/amazonBox--></div>

<div class="amazonBox">
<ul class="amazonImage"><li><a href="アマゾンリンク" class="external"><img src="" alt="商品名" width="150" height="150" /></a></li>
</ul>
<h3><a href="アマゾンリンク" class="external">商品名</a></h3>
<h4>著者名とか製造元名</h4>
<p>価格：  	<strong>￥ 12,210 </strong></p>
<!--/amazonBox--></div>

<div class="amazonBox">
<ul class="amazonImage"><li><a href="アマゾンリンク" class="external"><img src="" alt="商品名" width="150" height="150" /></a></li>
</ul>
<h3><a href="アマゾンリンク" class="external">商品名</a></h3>
<h4>著者名とか製造元名</h4>
<p>価格：  	<strong>￥ 12,210 </strong></p>
<!--/amazonBox--></div>

<div class="amazonBox first">
<ul class="amazonImage"><li><a href="アマゾンリンク" class="external"><img src="" alt="商品名" width="150" height="150" /></a></li>
</ul>
<h3><a href="アマゾンリンク" class="external">商品名</a></h3>
<h4>著者名とか製造元名</h4>
<p>価格：  	<strong>￥ 12,210 </strong></p>
<!--/amazonBox--></div>

<div class="amazonBox">
<ul class="amazonImage"><li><a href="アマゾンリンク" class="external"><img src="" alt="商品名" width="150" height="150" /></a></li>
</ul>
<h3><a href="アマゾンリンク" class="external">商品名</a></h3>
<h4>著者名とか製造元名</h4>
<p>価格：  	<strong>￥ 12,210 </strong></p>
<!--/amazonBox--></div>

<div class="amazonBox">
<ul class="amazonImage"><li><a href="アマゾンリンク" class="external"><img src="" alt="商品名" width="150" height="150" /></a></li>
</ul>
<h3><a href="アマゾンリンク" class="external">商品名</a></h3>
<h4>著者名とか製造元名</h4>
<p>価格：  	<strong>￥ 12,210 </strong></p>
<!--/amazonBox--></div>

<!--/amazon--></div>


<p class="goPageTop"><a href="#top">ページトップへ</a></p>
<!--/#main--></div>
<hr />

? } # endblock content


