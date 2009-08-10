<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja" dir="ltr">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="ja" />
<title>いなめなヶ崎</title>
<meta name="Description" content="あらゆるモノゴトにオチを" />
<meta name="Keywords" content="いなめなヶ崎,否めない" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta name="author" content="面白法人カヤック" />
<meta name="copyright" content="&copy;面白法人カヤック" />
<meta name="reply-to" content="info&#64;kayac.com" />
<link rel="shortcut icon" type="image/vnd.microsoft.icon" href="<?= $c->uri_for('/favicon.ico') ?>" />
<link rel="start" href="/" title="ホーム" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/homepage.css') ?>" media="screen, print" />
<!--[if lt IE 7]><link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/ie6.css') ?>" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/ie7.css') ?>" /><![endif]-->
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/print.css') ?>" media="print" />
<!--
どうもソースを見ていただきありがとうございます。
使えそうな部分がありましたら、どうぞお持ち帰りください！
問題がある部分を見つけましたら、お手数ですが下記までご連絡くださいませ。
http://bm11.kayac.com/contact
-->
</head>
<body>

<div id="bg">
<div id="container">

<div id="header">
<h1 id="siteName"><a href="<?= $c->uri_for('/') ?>" id="top"><img src="<?= $c->uri_for('/img/logo.png') ?>" alt="いなめなヶ崎" width="703" height="156" /></a></h1>
<!--/#header--></div>
<hr />

<div class="ad" id="ad1"><!--/adsence-->ここにアドセンスはいる</div>

<div id="content">
<? block content => '' ?>
<!--/#content--></div>

<div id="footer">
<dl id="kayacProject">
<dt><a href="http://www.kayac.com/" title="株式会社KAYAC（カヤック）古都鎌倉から新しい価値感のサービスを次々にリリースする面白法人" class="external"><img src="<?= $c->uri_for('/img/common/ico_kayacproject.gif') ?>" alt="KAYAC PROJECT" /></a></dt>
<dd>
<ul>
? my $service_footer = eval { $self->render('common/footer') };
? if ($service_footer) {
?= $service_footer
? } else {
<li><a href="http://www.houseco.jp/" class="external" title="建築家と注文住宅を建てる ハウスコ">建築家と注文住宅を建てる</a></li>
<li><a href="http://www.art-meter.com/" class="external" title="絵画の測り売り ART-Meter">絵画の測り売り</a></li>
<li><a href="http://www.shonan-clip.jp/" class="external" title="湘南情報 湘南Clip">湘南情報</a></li>
<li><a href="http://www.soumunomori.com/" class="external" title="総務情報 総務の森">総務情報</a></li>
<li><a href="http://www.blogdeco.jp/" class="external" title="ブログパーツ BlogDeco">ブログパーツ</a></li>
<li><a href="http://level0.kayac.com/" class="external" title="Flash情報 _level.0">Flash情報</a></li>
<li><a href="http://bowls-cafe.jp/" class="external" title="鎌倉 桜ランチ bowls">鎌倉 桜ランチ</a></li>
<li><a href="http://koebu.com/" class="external" title="声のコミュニティ こえ部">声のコミュニティ</a></li>
<li><a href="http://bm11.kayac.com/" class="external" title="面白ラボ bm11">面白ラボ</a></li>
<li><a href="http://mobile.kayac.jp/" class="external" title="面白無料携帯コンテンツ カヤックモバイル">面白無料携帯コンテンツ</a></li>
<li><a href="http://dododay.jp/" class="external" title="ものづくり応援サイト dododay">ものづくり応援サイト</a></li>
<li class="last"><a href="http://www.zackzack.jp/" class="external" title="攻めのクリエイティブ農業マガジン ザックザック">攻めのクリエイティブ農業マガジン</a></li>
? }
</ul>
</dd>
</dl>
<p id="copyright" class="vcard">Copyright &copy; <a href="http://www.kayac.com/" title="株式会社KAYAC（カヤック）古都鎌倉から新しい価値感のサービスを次々にリリースする面白法人" class="external fn org url">面白法人KAYAC</a> All Rights Reserved.</p>
<!--/#footer--></div>

<!--/#container--></div>

<!-- Scripts [-->
<script type="text/javascript" src="<?= $c->uri_for('/js/lib/jquery.js') ?>"></script>
<script type="text/javascript" src="<?= $c->uri_for('/js/sisso.js') ?>"></script>
<script type="text/javascript" src="<?= $c->uri_for('/js/meca.js') ?>"></script>
<script type="text/javascript" src="<?= $c->uri_for('/js/meca.config.js') ?>"></script>
<noscript><p id="msgNoscript">当サイトは、ブラウザのJavaScript設定を有効にしてご覧ください。</p></noscript>
<!--] Scripts-->

<!--Analytics [-->
<!--] Analytics-->

<!--/#bg--></div>


</body>
</html>