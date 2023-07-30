//
//  ViewController.swift
//  MovieProject
//
//  Created by 염성필 on 2023/07/28.
//

import UIKit

class ViewController: UITableViewController {
    
    var movieList = MovieList()
    
    var addMovieCount: Int = 0
    
    let encoder = JSONEncoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        
        print(#fileID, #function, #line,"- <#comment#>" )

        if let savedData = UserDefaults.standard.object(forKey: "MovieList") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([Movie].self, from: savedData) {
                movieList.movies = savedObject
                print("viewdidLoad - movieList.movies",movieList.movies)
            }
        }

    }
    
    @IBAction func addBtnClicked(_ sender: UIBarButtonItem) {
        
       
        addMovie()
        
        // => 해당 배열에 insert로 마지막 인덱스에 추가 했으니 count가 +1 되었음
        print("movieList.movies",movieList.movies.count)
        // => row에 count를 적으면 insert가 된 row를 reload하는게 아니라 +1 된 row를 reload하는 것이기 때문에 오류 발생
        // ⭐️ 해결 방법 : count - 1를 해서 추가 된 그 시점을 reload 해야 한다.
        
        let indexPath = IndexPath(row: movieList.movies.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
    
    func addMovie() {
        
        addMovieCount += 1
        
        let runtiem = Int.random(in: 100...150)
        let randomRate = Double.random(in: 1...10)
        let rate = Double(String(format: "%.f", randomRate))!
        
        movieList.movies.insert(Movie(title: "영화 제목 \(addMovieCount)", releaseDate: "영화 개봉일", runtime: runtiem, overview: "영화 줄거리 입니다.", rate: rate), at: movieList.movies.count)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }
        let row = movieList.movies[indexPath.row]
        
        cell.configureCell(row: row)
    
        return cell
    }
    
    // 테이블 뷰 삭제 메시드 추가
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
           
            movieList.movies.remove(at: indexPath.row)
            print("movieList.movies", movieList.movies)
            
            // 구조체가 들어감... UserDefaults에는 구조체가 들어 갈 수 없음 => 인코딩, 디코딩 작업 필요함
            /// encoded는 Data형
            // movieList.movies : 구조체 배열
            if let encoded = try? encoder.encode(movieList.movies) {
                UserDefaults.standard.setValue(encoded, forKey: "MovieList")
            }


            setUserdefaults()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell이 눌렸다 \(indexPath.row) , 영화 이름 : \(movieList.movies[indexPath.row].title)")

    }
    
    
    func setUserdefaults() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(movieList.movies) {
            UserDefaults.standard.setValue(encoded, forKey: "MovieList")
            print("UserDefaults 저장")
        }
    }
}
