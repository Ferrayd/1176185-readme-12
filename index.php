<?php
require_once 'helpers.php';

$connect = mysqli_connect("localhost", "root", "", "readme");
mysqli_set_charset($connect, "utf8mb4");

if ($connect === false) {
    print("Ошибка подключения: " . mysqli_connect_error());
}

$query = "SELECT p.*, ct.title, ct.icon_class, u.login, u.avatar FROM posts AS p JOIN content_type ct ON p.type_id = ct.id JOIN users u ON p.author_id = u.id ORDER BY p.views DESC LIMIT 6";
$result = mysqli_query($connect, $query);
$posts = mysqli_fetch_all($result, MYSQLI_ASSOC);

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
function getPublicationTime($key) {
    $publicationDate = new DateTime(generate_random_date($key));
    return $publicationDate->format("c");
};


function getFormatTime($key) {
    $publicationDate = new DateTime(generate_random_date($key));
    $timeFormat = $publicationDate->format("d.m.Y H:i");
    return $timeFormat;
};

function getRelativeFormat($index) {
    $curentDate = new DateTime("", new DateTimeZone("Europe/Moscow"));
    $publicationDate = new DateTime(generate_random_date($index));
    $difference = $curentDate->diff($publicationDate);
    $minutes = $difference->i;
    $hours = $difference->h;
    $days = $difference->d;
    $weeks = floor($days / 7);
    $months = $difference->m;

    $minute = get_noun_plural_form($minutes, 'минуту', 'минуты', 'минут');
    $hour = get_noun_plural_form($hours, 'час', 'часа', 'часов');
    $day = get_noun_plural_form($days, 'день', 'дня', 'дней');
    $week = get_noun_plural_form($weeks, 'неделю', 'недели', 'недель');
    $month = get_noun_plural_form($months, 'месяц', 'месяца', 'месяцев');

    if ($months > 0) {
        $timeDifference = "{$months} {$month} назад";
    } elseif ($weeks > 0) {
        $timeDifference = "{$weeks} {$week} назад";
    } elseif ($days > 0) {
        $timeDifference = "{$days} {$day} назад";
    } elseif ($hours > 0) {
        $timeDifference = "{$hours} {$hour} назад";
    } elseif ($minutes > 0) {
        $timeDifference = "{$minutes} {$minute} назад";
    }

    return $timeDifference;
};


$page_content = include_template('main.php', [
    'gifs' => $posts,

]);

$pageInfo = [
    $is_auth = rand(0, 1),
    'title' => 'readme: популярное',
    'page_content' => $page_content,
];

$layout = include_template('layout.php', $pageInfo);

print($layout);
