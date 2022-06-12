//
//  DummyData.swift
//  Homework-3
//
//  Created by Kazakova Nataliya on 01.06.2022.
//

enum DummyData {
    static let books: [Book] = [
        .init(title: "Никола Тесла",
              author: "Евгений Матонин",
              genre: .biographiesAndMemoirs,
              yearOfPublishing: 2019,
              tags: [
                .init(title: "#выбор редакции", number: 1),
                .init(title: "#бестселлер", number: 2),
                .init(title: "#актуальное", number: 3)
              ],
              image: "https://www.storytel.com/images/640x640/0000840009.jpg"),
        .init(title: "Михаил Булгаков",
              author: "Мастер и Маргарита",
              genre: .mystic,
              yearOfPublishing: 1967,
              tags: [.init(title: "#снят фильм", number: 5), .init(title: "#психология", number: 6)],
              image: "https://cdn.eksmo.ru/v2/ITD000000000963786/COVER/cover1__w600.jpg"),
        .init(title: "Макбет",
              author: "Уильям Шекспир",
              genre: .dramaturgy,
              yearOfPublishing: 1623,
              tags: [.init(title: "#выбор редакции", number: 1), .init(title: "#бестселлер", number: 2)],
              image: "https://liteka.ru/img/1809/1b/ba/5d4cec0e4a24896176c0.jpg"),
        .init(title: "Гордость и предубеждение",
              author: "Джейн Остин",
              genre: .romanceNovels,
              yearOfPublishing: 1813,
              tags: [
                .init(title: "#актуальное", number: 3),
                .init(title: "#психология", number: 6),
                .init(title: "#снят фильм", number: 5)
              ],
              image: "https://s1.livelib.ru/boocover/1000404342/200/ff2b/boocover.jpg"),
        .init(title: "Воля к смыслу",
              author: "Виктор Франкл",
              genre: .nonFiction,
              yearOfPublishing: 2018,
              tags: [
                .init(title: "#психология", number: 6),
                .init(title: "#иностранное", number: 7),
                .init(title: "#саморазвитие", number: 8)
              ],
              image: "https://cv8.litres.ru/pub/c/audiokniga/cover_max1500/42538085-viktor-frankl-volya-k-smyslu-42538085.jpg"),
        .init(title: "Дюна",
              author: "Фрэнк Герберт",
              genre: .fiction,
              yearOfPublishing: 2014,
              tags: [.init(title: "#актуальное", number: 3)],
              image: "https://cv1.litres.ru/pub/c/elektronnaya-kniga/cover/122116-frenk-gerbert-duna.jpg"),
        .init(title: "Нулевой пациент. О больных, благодаря которым гениальные врачи стали известными",
              author: "Люк Перино",
              genre: .lifeStories,
              yearOfPublishing: 2020,
              tags: [.init(title: "#выбор редакции", number: 1), .init(title: "#бестселлер", number: 2)],
              image: "https://bmm.ru/upload/iblock/365/365bfb86354f54cf0c1336d9677241f8.jpg"),
        .init(title: "Дневник Бриджит Джонс",
              author: "Хелен Филдинг",
              genre: .romanceNovels,
              yearOfPublishing: 1996,
              tags: [.init(title: "#снят фильм", number: 5), .init(title: "#иностранное", number: 7)],
              image: "https://cv5.litres.ru/pub/c/elektronnaya-kniga/cover_330/8226653-helen-filding-dnevnik-bridzhit-dzhons.jpg"),
        .init(title: "Девушка с татуировкой дракона",
              author: "Стиг Ларссон",
              genre: .detective,
              yearOfPublishing: 2005,
              tags: [.init(title: "#актуальное", number: 5), .init(title: "#иностранное", number: 7)],
              image: "https://listread.com/photo/books/longdesc/5263-devushka_s_tatuirovkoy_drakona.jpg"),
        .init(title: "Я, робот",
              author: "Айзек Азимов",
              genre: .fiction,
              yearOfPublishing: 1950,
              tags: [.init(title: "#психология", number: 6), .init(title: "#бестселлер", number: 2)],
              image: "https://s1.livelib.ru/boocover/1000317401/o/b5b1/Ajzek_Azimov__Ya_robot_sbornik.jpeg")
    ]
    
    static let data: [ListItemViewModel] = books.map {
        .init(title: "\($0.title). \($0.author)",
              genre: $0.genre.rawValue,
              yearOfPublishing: String($0.yearOfPublishing),
              tags: $0.tags,
              image: $0.image)
    }
}
