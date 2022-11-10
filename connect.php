<?php
$connect = mysqli_connect("localhost", "root", "", "readme");
mysqli_set_charset($connect, "utf8mb4");

if (!$connect) {
    $error = mysqli_connect_error();
    print($error);
}
else {
    $query = "SELECT p.*, ct.title, ct.icon_class, u.login, u.avatar FROM posts AS p JOIN content_type ct ON p.type_id = ct.id JOIN users u ON p.author_id = u.id ORDER BY p.views DESC LIMIT 6";
    $result = mysqli_query($connect, $query);

    if ($result) {
        $posts = mysqli_fetch_all($result, MYSQLI_ASSOC);
    }
    else {
        print(mysqli_error($connect));
    }
}