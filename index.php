<?php
require_once 'helpers.php';
$is_auth = rand(0, 1);
$gifs = [
    [
        'header' => 'Цитата',
        'type' => 'post-quote',
        'content' => 'Мы в жизни любим только раз, а после ищем лишь похожих',
        'username' => 'Лариса',
        'avatar' => 'userpic-larisa-small.jpg'
    ],
    [
        'header' => 'Игра престолов',
        'type' => 'post-text',
        'content' => 'Не могу дождаться начала финального сезона своего любимого сериала!',
        'username' => 'Владик',
        'avatar' => 'userpic.jpg'
    ],
    [
        'header' => 'Наконец, обработал фотки!',
        'type' => 'post-photo',
        'content' => 'rock-medium.jpg',
        'username' => 'Виктор',
        'avatar' => 'userpic-mark.jpg'
    ],
    [
        'header' => 'Моя мечта',
        'type' => 'post-photo',
        'content' => 'coast-medium.jpg',
        'username' => 'Лариса',
        'avatar' => 'userpic-larisa-small.jpg'
    ],
    [
        'header' => 'Лучшие курсы',
        'type' => 'post-link',
        'content' => 'www.htmlacademy.ru',
        'username' => 'Владик',
        'avatar' => 'userpic.jpg'
    ],
];
/**
 * Функция позволяет ограничить длину строки с обрезанием по целому слову. 
 * 
 * @param string $string Входная строка
 * @param int $limit Максимально допустимое число символов. Если строка $string меньше входного лимита, будет возвращена строка, обернутая в тег <p>, в противном случае, к ней будет добавлена ссылка на полный пост. Значение параметра не может быть отрицательным.
 * @return string Входная строка, влезающая в указанную длину по символам, обрамленная в теги p и a по необходимости.
 * @param $words Слова из которых состоит входная строка
 * @param $count Переменная используемая в качестве счетчика внутри цикла
 * @param $splitString Строка в которую будут объеденины слова из массива для вывода
 * @param $newWords Массив для заполнения словами
 * Функция возвращает string 
 */
function divideString(string $string, int $limit = 300)
{
    if (mb_strlen($string, 'UTF-8') < $limit) {
        return "<p>{$string}</p>";
    }
    $words = explode(" ", $string);
    $count = 0;
    $splitString = "";
    $newWords = [];

    foreach ($words as $elem) {
        $count += mb_strlen($elem, "UTF-8");

        if ($count < $limit) {
            array_push($newWords, $elem);
        };
    };

    $splitString = implode(" ", $newWords);

    return "<p>{$splitString}...</p><a class=\"post-text__more-link\" href=\"#\">Читать далее</a>";
};
$user_name = 'Станислав'; // укажите здесь ваше имя

$page_content = include_template('main.php', ['gifs' => $gifs]);

$pageInfo = [
    $is_auth = rand(0, 1),
    'title' => 'readme: популярное',
    'page_content' => $page_content,
];

$layout = include_template('layout.php', $pageInfo);

print($layout);

?>
