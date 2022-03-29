from django.test import TestCase
from paypalrestsdk import BillingPlan

billing_plan = BillingPlan({
    "name": "Fast Speed Plan",
    "description": "Create Plan for Regular",
    "merchant_preferences": {
        "auto_bill_amount": "yes",
        "cancel_url": "http://www.paypal.com/cancel",
        "initial_fail_amount_action": "continue",
        "max_fail_attempts": "1",
        "return_url": "http://www.paypal.com/execute",
        "setup_fee": {
            "currency": "GBP",
            "value": "25"
        }
    },
    "payment_definitions": [
        {
            "amount": {
                "currency": "GBP",
                "value": "100"
            },
            "charge_models": [
                {
                    "amount": {
                        "currency": "GBP",
                        "value": "10.60"
                    },
                    "type": "SHIPPING"
                },
                {
                    "amount": {
                        "currency": "GBP",
                        "value": "20"
                    },
                    "type": "TAX"
                }
            ],
            "cycles": "0",
            "frequency": "MONTH",
            "frequency_interval": "1",
            "name": "Regular 1",
            "type": "REGULAR"
        }
    ],
    "type": "INFINITE"
})

response = billing_plan.create()
print(response)
# Create your tests here.
