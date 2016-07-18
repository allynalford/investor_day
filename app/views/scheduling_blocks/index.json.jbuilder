json.array!(@scheduling_blocks) do |scheduling_block|
  json.extract! scheduling_block, :id, :start_time, :bookable
  json.url scheduling_block_url(scheduling_block, format: :json)
end
