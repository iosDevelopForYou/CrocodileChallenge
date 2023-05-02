//
//  Category.swift
//  CrocodileChallenge
//
//  Created by Владислав Резник on 19.04.2023.
//

import Foundation

struct Category {
    let avatar: String
    let title: String
    let color: String
    
    static func getCategories() -> [Category] {
        return [
            Category(avatar: Resources.Images.frog, title: "Животные", color: Resources.Colors.purple),
            Category(avatar: Resources.Images.burger, title: "Еда", color: Resources.Colors.lightGreen),
            Category(avatar: Resources.Images.cowboy, title: "Личности", color: Resources.Colors.blue),
            Category(avatar: Resources.Images.nails, title: "Хобби", color: Resources.Colors.red)
        ]
    }
}

    enum typeCategory: String {
        case animal = "Животные"
        case food = "Еда"
        case persons = "Личности"
        case hobby = "Хобби"

    }

    struct Words {
        var category: Category

        init(category: Category) {
            self.category = category
        }

        func getWords() -> [String] {
            guard let type = typeCategory(rawValue: category.title) else { return [] }
            switch type {

            case .animal:
                return [
                    "Собака",
                    "Креветка",
                    "Пеликан",
                    "Осьминог",
                    "Енот-полоскун",
                    "Скунс",
                    "Пеликан",
                    "Ленивец",
                    "Лиса",
                    "Лев",
                    "Краб",
                    "Улитка",
                    "Белка",
                    "Павлин",
                    "Змея",
                    "Скорпион",
                    "Муха",
                    "Пчела",
                    "Морской конек",
                    "Осёл"
                ]
            case .food:
                return [
                    "Оливье",
                    "Борщ",
                    "Булочка",
                    "Хлеб",
                    "Молоко",
                    "Сметана",
                    "Кефир",
                    "Мороженное",
                    "Мясо",
                    "Шашлык",
                    "Торт",
                    "Зефир",
                    "Помидор",
                    "Огурец",
                    "Лук",
                    "Банан",
                    "Арбуз",
                    "Кабачок",
                    "Баклажан",
                    "Икра",
                    "Кофе"
                ]
            case .persons:
                return [
                    "Бейонсе Ноулз-Картер",
                    "Леброн Джеймс",
                    "Джо Байден",
                    "Дуэйн Джонсон",
                    "Тейлор Свифт",
                    "Бритни Спирз",
                    "Дональд Трамп",
                    "Илон Маск",
                    "Лионель Месси",
                    "Криштиану Роналдо",
                    "Билл Гейтс",
                    "Марк Цукерберг",
                    "Джастин Бибер",
                    "Филипп Киркоров",
                    "Юрий Гагарин",
                    "Ким Чен Ын",
                    "Королева Елизавета",
                    "Дженифер Энистон",
                    "Стив Джобс",
                    "Папа Римский"
                ]
            case .hobby:
                return [
                    "Боевые искусства",
                    "Лыжи",
                    "Футбол",
                    "Волейбол",
                    "Теннис",
                    "Йога",
                    "Пеший туризм",
                    "Кемпинг",
                    "Аэрография",
                    "Создание мебели",
                    "Программирование",
                    "Пчеловодство",
                    "Цветоводство",
                    "Коллекционирование",
                    "Фокусы",
                    "Астрология",
                    "Выпечка",
                    "Пивоварение",
                    "Бодиарт",
                    "Фотография"
                ]
            }
        }

        func getActions() -> [String] {
            return [
                "Объясни с помощью слов",
                "Объясни с помощью жестов",
                "Объясни с помощью рисунка",
                "Объясняй со злостью",
                "Объясняй с помощью мимики",
                "Объясняй вульгарно",
                "Объясняй сексуально"
            ]
        }
    }
