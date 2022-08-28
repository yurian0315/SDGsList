// js ファイルが読み込まれた時にログを出力する。
console.log("checkbox.js");

// image0 という id の要素に、クリックした時の処理を設定する。
document.getElementById('image0').onclick = function() {
    // checkbox0 という id の要素を取得し、 checkbox という変数に代入する。
    const checkbox = document.getElementById('checkbox0');
    // checkbox0 の値を切り替える。
    checkbox.checked = !checkbox.checked;
    // checkbox0 の値をログに出力する。
    console.log(checkbox.checked);
};

document.getElementById('image1').onclick = function() {
    const checkbox = document.getElementById('checkbox1');
    checkbox.checked = !checkbox.checked;
    console.log(checkbox.checked);
};

document.getElementById('image2').onclick = function() {
    const checkbox = document.getElementById('checkbox2');
    checkbox.checked = !checkbox.checked;
    console.log(checkbox.checked);
};
