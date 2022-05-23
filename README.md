# REST API - Reservation application

## Install

    bundle install
    
#### Additional Gems used
    - jbuilder
    - rspec-rails
    - rails-controller-testing
    - shoulda-matchers
    - factory_bot
    - factory_bot_rails

## Run the app

    rails s

## Run the tests

    rspec

## Approaches
   - create helper to handle the params https://github.com/fatkhanfauzi/rails-reservation-api/blob/master/app/helpers/reservations_helper.rb
   - rescue error in base class https://github.com/fatkhanfauzi/rails-reservation-api/blob/master/app/controllers/application_controller.rb
   - use transaction scope in service https://github.com/fatkhanfauzi/rails-reservation-api/blob/master/app/services/reservation_service.rb
   - use jbuilder to apply proper json structure in response
   - create specs for:
      - controllers
      - services
      - models

# REST API

The REST API to the example app is described below.

## Get list of Reservations

### Request

`GET /v1/reservations`

### Response

    HTTP/1.1 200 OK
    
    {
        "meta": {
            "count": 1
        },
        "data": [
            {
                "type": "reservation",
                "id": 4,
                "attributes": {
                    "uuid": "e3ce4497-0022-4d62-a1b7-d6d55d4a930d",
                    "reservation_code": "XXX123456728",
                    "start_date": "2021-03-12T00:00:00.000Z",
                    "end_date": "2021-03-16T00:00:00.000Z",
                    "nights": 4,
                    "guests": 4,
                    "adults": 2,
                    "children": 2,
                    "infants": 0,
                    "status": "accepted",
                    "currency": "AUD",
                    "payout_price": 3800.0,
                    "security_price": 500.0,
                    "total_price": 4300.0
                },
                "relationships": {
                    "guest": {
                        "type": "guest",
                        "id": 3,
                        "attributes": {
                            "uuid": "ac353fa1-1da9-40c2-968a-1deffedd029e",
                            "first_name": "Wayne",
                            "last_name": "Woodbridge",
                            "phone": "639123456789",
                            "email": "wayne_woodbridge@bnb.com"
                        }
                    }
                }
            }
        ]
    }


## Create a new Reservation

### Request

`POST v1/reservations/`

#### Payload 1

    {
      "reservation_code": "YYY124522222",
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbr2idge@bnb.com"
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00"
    }

#### Payload 2

    {
      "reservation": {
        "code": "XXX123456728",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0
        },
        "guest_email": "wayne_woodbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00"
      }
    }

### Response

    HTTP/1.1 201 Created
   
    Response will be the same as #show
   
## Create Reservation with existed reservation code

### Request

    Will be the same as #create

### Response
    HTTP/1.1 400 Bad Request

    {
        "reservation_code": [
            "has already been taken"
        ]
    }

## Get a specific Reservation

### Request

`GET v1/reservations/:uuid`

### Response

    HTTP/1.1 200 OK
 
    {
        "data": {
            "type": "reservation",
            "id": 3,
            "attributes": {
                "uuid": "20ab33d2-4f5a-44b1-85f3-eae17d24a3a8",
                "reservation_code": "YYY124522222",
                "start_date": "2021-04-14T00:00:00.000Z",
                "end_date": "2021-04-18T00:00:00.000Z",
                "nights": 4,
                "guests": null,
                "adults": 2,
                "children": 2,
                "infants": 0,
                "status": "accepted",
                "currency": "AUD",
                "payout_price": 4200.0,
                "security_price": 500.0,
                "total_price": 4700.0
            },
            "relationships": {
                "guest": {
                    "type": "guest",
                    "id": 1,
                    "attributes": {
                        "uuid": "70f8e21b-d766-448a-9ad8-fe18fb807e34",
                        "first_name": "Wayne",
                        "last_name": "Woodbridge",
                        "phone": "639123456789",
                        "email": "wayne_woodbr2idge@bnb.com"
                    }
                }
            }
        }
    }

## Get a non-existent Reservation

### Request

`GET v1/reservations/:uuid`

### Response

    HTTP/1.1 404 Not Found

    {
        "error": "Couldn't find Reservation"
    }

## Update Reservation

### Request

`PUT v1/reservations/:uuid`

    Request will be the same as #create


### Response

    HTTP/1.1 200 OK

    Response will be the same as #show

## Delete a Reservation

### Request

`DELETE v1/reservations/:uuid`

### Response

    HTTP/1.1 204 No Content

## Try to delete same Reservation again

### Request

`DELETE v1/reservations/:uuid`

### Response

    HTTP/1.1 404 Not Found

    {
        "error": "Couldn't find Reservation"
    }


