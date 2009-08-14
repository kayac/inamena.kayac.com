use Inamena::Test;

no utf8; # because $res->content should be utf8 bytes

{
    # /default
    my $res = request GET => '/not_found_page';
    is $res->code, 404, '404 ok';
    like $res->content, qr!<title>404 - Not Found</title>!, '404 content ok';
}

{
    # /error_handler
    no warnings 'once', 'redefine';
    local *Inamena::Controller::Root::index = sub { die };

    my $res = request GET => '/';
    is $res->code, 500, '500 ok';
    like $res->content, qr!<title>500 - Internal Server Error</title>!, '500 content ok';
}

{
    # /index
    my $res = request GET => '/';
    is $res->code, 200, '200 ok';
    like $res->content, qr!<title>いなめなヶ崎</title>!, 'content ok';
}

{
    # /result
    my $res = request GET => '/イチロー';
    is $res->code, 200, '200 ok';
    like $res->content, qr!<title>イチローの否めないエピソード | いなめなヶ崎</title>!,
        'ichiro content ok';
}

done_testing;
