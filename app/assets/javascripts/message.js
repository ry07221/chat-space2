$(document).on('turbolinks:load', function(){
  
  function buildHTML(message){
    var image = message.image? `<img src="${message.image}" class="content__message__image">` : " " ;
    var html = `<div class="message" data-id='${message.id}'>
                  <div class="message__upper">
                    <div class="message__upper__user">${message.user_name}</div>
                    <div class="message__upper__date">${message.created_at}</div>
                  </div>
                  <div class="message__lower">
                    ${message.content}
                    ${image}
                  </div>
                </div>`
      return html;
  }


  
  $('.new_message').on('submit',function(e){  //イベントの発火元は送信ボタンではなくて、フォーム全体の情報を送り
                                              //たいからフォームタグのクラスを指定
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false,
    })
    .done(function(data){ 
      var html = buildHTML(data);    
      $('.messages').append(html);            
      $('.messages').animate({scrollTop:$('.messages')[0].scrollHeight});
      $('#new_message')[0].reset();
      $(".new_message__submit").prop('disabled', false)
    })
    .fail(function(){
      alert('failed to send Messages');
    })
    return false;
  });


  var reloadMessages = function() {

    
    if (window.location.href.match(/\/groups\/\d+\/messages/)){  //前半→ページ遷移に使う，後半→それにマッチするもの
      //グループに入ったときのみ、自動更新する
    last_message_id = $(".message:last").data("id") || 0;  //共に空の場合も考慮(0を入れる)
      //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得

      $.ajax({
      type: "GET",
      url: "api/messages",
      data: {id: last_message_id},  //dataオプションでリクエストに値を含める
      dataType: 'json',
    })
    
    .done(function(messages){
      if (messages.length != 0){
      var insertHTML = '';     //追加するHTMLの入れ物を作る
      messages.forEach(function(message){
          insertHTML = buildHTML(message);
          $('.messages').append(insertHTML);
          $('.messages').animate({scrollTop:$('.messages')[0].scrollHeight});
        })
      }
    })

    .fail(function(){
      alert('failed to auto renewal');
    })
    
  };
  
}
setInterval(reloadMessages, 5000);
})
