// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require chartkick
//= require Chart.bundle

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


// //$(function () {
// // キャッシュの開始前
//     $(document).on('turbolinks:before-cache', function() {
//         $('#calendar').html('');
//     });

//     // ページの読み込み時
//     $(document).on('turbolinks:load', function () {
//         if ($('#calendar').length > 0 ) {

//             //events: '/events.json', 以下に追加
//             $('#calendar').fullCalendar({
//                 googleCalendarApiKey: 'AIzaSyB-7uQdd7ffahHDIS48WdDVN3U8Nw9us6I',
//                 events: {
//                       googleCalendarId: 'ja.japanese#holiday@group.v.calendar.google.com'
//                 },

//                 events: '/events.json',

//                 //カレンダー上部を年月で表示させる
//                 titleFormat: 'YYYY年 M月',
//                 //曜日を日本語表示
//                 dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
//                 //ボタンのレイアウト、月、週、日でカレンダー表示
//                 header: {
//                     left: 'month, agendaWeek, agendaDay',
//                     center: 'title',
//                     right: 'today prev,next'
//                 },
//                 // 高さ
//                 height: 650,
//                 //終了時刻がないイベントの表示間隔
//                 defaultTimedEventDuration: '03:00:00',
//                 // デフォルトで週間カレンダーを表示
//                 defaultView: 'agendaWeek',
//                 buttonText: {
//                     prev: '前',
//                     next: '次',
//                     prevYear: '前年',
//                     nextYear: '翌年',
//                     today: '今日',
//                     month: '月',
//                     week: '週',
//                     day: '日'
//                 },
//                 // Drag & Drop & Resize
//                 editable: true,
//                 //イベントの時間表示を２４時間に
//                 timeFormat: "HH:mm",
//                 //イベントの色を変える
//                 eventColor: '#87cefa',
//                 //イベントの文字色を変える
//                 eventTextColor: '#000000',
//                 eventRender: function(event, element) {
//                     element.css("font-size", "0.8em");
//                     element.css("padding", "5px");
//                 }
//             });
//         }
//     });
// //});
  document.addEventListener("DOMContentLoaded", function () {
$(function() {
    $("div.top dl").each(function(i) {
        setTimeout(function() {
            $("div.top dl").eq(i).addClass("active");
        }, 200 * i);
    });
});
 });

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})