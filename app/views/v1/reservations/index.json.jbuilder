json.meta do
  json.count @reservations.size
end
json.data do
  json.array! @reservations.each do |reservation|
    json.partial! 'v1/reservations/item', item: reservation
    json.partial! 'v1/reservations/relationships', item: reservation
  end
end
