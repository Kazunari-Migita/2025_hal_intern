import 'package:flutter/material.dart';

void main() {
  // 最初に表示するWidget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      // リスト一覧画面を表示
      home: const TodoListPage(),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Todoリストデータ
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: const Text('リスト一覧'),
      ),
      // ListViewを使いリスト一覧を表示する
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
          // "push"で新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return const TodoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は newListText が null となるので注意
            setState(() {
              // リスト追加
              todoList.add(newListText);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// リスト追加画面用Widget
class TodoAddPage extends StatefulWidget {
  const TodoAddPage({super.key});

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト追加'),
      ),
      body: Container(
        //余白をつける。
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示
            Text(_text,style: const TextStyle(color: Color.fromARGB(255, 2, 0, 1))),
            const SizedBox(height: 8),
            //テキスト入力
            TextField(
            // 入力されたテキストの値を受け取る(valueで入力されたテキスト)
            onChanged: (String value) {
              // データが変更したことを知らせる(画面を更新する)
              setState(() {
                // データを更新
                _text = value;
              });
            },
            ),
            const SizedBox(height: 8),
            SizedBox(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: (){
                  // popで前の画面に戻る
                  // popの引数から前の画面いデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: const Text('リスト追加', style: TextStyle(color: Color.fromARGB(255, 238, 0, 0))),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
              // ボタンをクリックした時の処理
              onPressed: (){
                //popで前の画面に戻る
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
              ),
            )
            ]
            ),
      ),
    );
  }
}
