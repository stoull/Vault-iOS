//
//  VTMovie.swift
//  Vault
//
//  Created by Kevin on 2023/7/20.
//

import Foundation

struct VTMovieList: Codable {
    
}

struct VTMovie: Codable, Identifiable {
    let id: Int
    let name: String
    let directors: String
    let scenarists: String
    let actors: String
    let style: String
    let year: Int
    let release_date: String
    let area: String
    let language: String
    let length: Int
    let other_names: String?
    let score: Double
    let rating_number: Int
    let synopsis: String?
    let imdb: String?
    let poster_name: String?
    let filePath: String?
    let fileUrl: String?
    let is_downloaded: Int
    let download_link: String?
    let create_date: String
    let lastWatch_date: String?
    let lastWatch_user: String?
    
    static func sampleMovie() -> VTMovie {
        let jsonData = """
{"actors": "赵涛, 韩三明, 王宏伟, 李竹斌, 项海渔, 周林", "area": "中国大陆", "create_date": "2022-07-04 03:10:49", "directors": "贾樟柯", "download_link": null, "filePath": "/中国/贾樟柯/三峡好人.Still.Life.2006.BD1080P.国语中字.mp4", "fileUrl": null, "id": 1872133, "imdb": "tt0859765", "is_downloaded": 1, "language": "四川话 / 晋语", "lastWatch_date": null, "lastWatch_user": null, "length": 107, "name": "三峡好人", "other_names": "长江哀歌 / Still Life", "poster_name": "p520162740.jpg", "rating_number": 124542, "release_date": "2006-12-14(中国大陆) / 2006-09-06(威尼斯电影节)", "scenarists": "贾樟柯, 管娜, 孙建敏", "score": 8.3, "style": "剧情 / 爱情", "synopsis": "三峡建设工作正在进行中的奉节县城，迎来一男一女两个山西人。                                                                    　　男人韩三明（韩三明 饰）来自汾阳，是名忠厚老实的煤矿工人，来奉节为寻十六年未见的前妻。前妻是他当年用钱买来的，生完孩子后跑回了奉节。寻找前妻的过程中波折不断，韩三明决定留下来做苦力一直等到前妻出现。女人沈红（赵 涛 饰）来自太原，是名沉默寡言的护士，为寻多日不曾与自己联系的丈夫而来奉节。丈夫与她的夫妻关系早已是有名无实，这点她虽然深知，仍想让丈夫当面给她个说法。沈红的找寻过程也不是一帆风顺，丈夫在有意无意地躲着她。韩三明和沈红虽不认识，却因为要做相对意义上的“拿起”与“舍弃”抉择，在冥冥之中有了某种神秘的联系。                                                                    　　本片荣获2006年第63届威尼斯国际电影节金狮奖。", "year": 2006}
""".data(using: .utf8)!
        return try! JSONDecoder().decode(VTMovie.self, from: jsonData)
    }
}


