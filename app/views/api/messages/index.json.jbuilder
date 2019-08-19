 json.array! @messages do |message|    #取得するメッセージは複数ある可能性があるため、配列でレスポンスする
  json.content message.content
  json.image message.image.url
  json.created_at message.created_at.to_s(:default)
  json.user_name message.user.name
  json.id message.id
end
