json.data do
  json.partial! 'v1/reservations/item', item: @reservation
  json.partial! 'v1/reservations/relationships', item: @reservation
end
