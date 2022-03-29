from django.db import models
import paypalrestsdk
import logging

paypalrestsdk.configure({
  "mode": "sandbox", # sandbox or live
  "client_id": "AUN871xpue4U-WMyHi3lqgwo8xByk4KA3UykduTfuuVxgZ4ErmqeO17axqEBBQo8ER26PlAAX9As9eYT",
  "client_secret": "EIdf-Ya9BzSyyegIqfrTHDAfaAKr_QgnqWFLTeHWF7ctY1-_PqYaytNEsP-DhHr9DYa3EfoqNtYmxm2Q" })

payment = paypalrestsdk.Payment({
    "intent": "sale",
    "payer": {
        "payment_method": "paypal"},
    "redirect_urls": {
        "return_url": "https://www.baidu.com",
        "cancel_url": "https://www.google.com"},
    "transactions": [{
        "item_list": {
            "items": [{
                "name": "item",
                "sku": "item",
                "price": "5.00",
                "currency": "GBP",
                "quantity": 1}]},
        "amount": {
            "total": "5.00",
            "currency": "GBP"},
        "description": "This is the payment transaction description."}]})

if payment.create():
  print("Payment created successfully")
else:
  print(payment.error)
# Create your models here.
