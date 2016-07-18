json.array!(@rankings) do |ranking|
  json.extract! ranking, :id, :rankee_id, :rankee_type, :ranker_id, :ranker_type, :score
  json.url ranking_url(ranking, format: :json)
end
