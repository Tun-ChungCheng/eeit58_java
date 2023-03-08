// 10. 如果是這樣寫的話，有錯誤訊息，為什麼？ Q: 畫面還沒準備好
// btnGet.onclick = function () {
//     console.log('OK')
// }

// 11. 畫面準備好以後才開始執行
$(function () {
    btnGet.onclick = function () {
        console.log('OK')

        // 20. 取得 姓名欄位 (使用 JavaScript 的方式)
        // 21. 取得 姓名欄位 (使用 jQuery 的方式)

        console.log(document.getElementById('userName').value)
        console.log($('#userName').val())

        // 30. 取得 地址欄位 (使用 JavaScript 的方式)
        // 31. 取得 地址欄位 (使用 jQuery 的方式)

        console.log(document.getElementById('address').value)
        console.log($('#address').val())

        // 40. 取得 年紀欄位 (使用 JavaScript 的方式)
        // 41. 取得 年紀欄位 (使用 jQuery 的方式)

        console.log(document.querySelector('input[name="age"]:checked').value)
        console.log($('input[name="age"]:checked').val())
    }
})
