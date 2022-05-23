json.relationships do
  if item.guest.present?
    json.guest do
      json.partial! 'v1/guests/item', item: item.guest
    end
  end
end
