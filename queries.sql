/*добавляет список типов контента для поста*/
INSERT INTO content_type (title, icon_class)
VALUES
('Цитата', 'post-quote'),
('Текст', 'post-text'),
('Фото', 'post-photo'),
('Ссылка', 'post-link');

/*добавляет пользователей*/
INSERT INTO users (reg_date, email, login, password, avatar)
VALUES
('2022.01.02 23:24:21', 'vl@mail.ru', 'Влад', 'vlad', 'userpic1.jpg'),
('2022.06.22 15:24:25', 'igor@yandex.ru', 'Игорь', 'igor', 'userpic2.jpg'),
('2022.08.13 12:02:43', 'artem@yandex.ru', 'Артем', 'artem', 'userpic3.jpg');
('2022.08.13 12:02:43', 'lar@yandex.ru', 'Лариса', 'lar', 'userpic-larisa-small.jpg');
('2022.08.13 12:02:43', 'aiv@yandex.ru', 'Иван', 'ivan', 'userpic4.jpg');

/*добавляет существующий список постов*/
INSERT INTO posts (title, content, views, author_id, type_id)
VALUES
('Цитата', 'Мы в жизни любим только раз, а после ищем лишь похожих', 100, 1, 4),
('Игра престолов', 'Не могу дождаться начала финального сезона своего любимого сериала!', 5000, 2, 2),
('Наконец, обработал фотки!', 'rock-medium.jpg', 150, 3, 3),
('Моя мечта', 'coast-medium.jpg', 10000, 1, 3);

/*комментарии к разным постам*/
INSERT INTO comments (creation_date, content, author_id, post_id)
VALUES
('2022.01.02 21:17:21', 'Прекрасная обработка! Так держать!', 1, 3),
('2022.02.02 11:00:00', 'Просто берет за душу!', 2, 1),
('2022.03.08 12:01:23', 'Лучше курсов не стречал!', 3, 2);

/*получает список постов с сортировкой по популярности и вместе с именами авторов и типом контента;*/
SELECT p.*, ct.title, u.login, u.avatar
FROM posts AS p
JOIN content_type ct ON p.type_id = ct.id
JOIN users u ON p.author_id = u.id
ORDER BY p.views DESC;

/*получает список постов для конкретного пользователя*/
SELECT p.title, p.content, u.login, p.views
FROM posts AS p
LEFT JOIN users AS u ON p.author_id=u.id
WHERE u.id=1;

/*получает список комментариев для одного поста, в комментариях должен быть логин пользователя*/
SELECT c.creation_date, c.content, u.login
FROM comments AS c
LEFT JOIN users AS u ON c.id=u.id
WHERE c.post_id=1;

/*добавление лайка посту*/
INSERT INTO likes (user_id, liked_post) VALUES (2, 4);

/*подписка на пользователя*/
INSERT INTO subscription (follower, user_id) VALUES (3, 1);