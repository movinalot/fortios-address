""" FortiOS Address and Adress Group Management """

import time
import json
import os
from csv import DictReader
import requests

requests.packages.urllib3.disable_warnings()

COMMON_HEADERS = {"Content-type": "application/json", "Accept": "application/json"}
SSL_VERIFY = False

if __name__ == "__main__":

    # Set credentials in enviroment or locally
    FORTIGATE_API_TOKEN = os.getenv(
        "FORTIGATE_API_TOKEN", "ckGhjcbqy1c47jjgzj957sgktxwx15"
    )
    FORTIGATE_URL = os.getenv(
        "FORTIGATE_URL", "fortigate-url-goes-here"
    )  # E.g. https://10.10.10.10/

    headers = COMMON_HEADERS.copy()
    headers["Authorization"] = f"Bearer {FORTIGATE_API_TOKEN}"

    with open("addresses_and_groups.csv", "r", encoding="utf-8") as csv_file:
        addresses = DictReader(csv_file)

        for address in addresses:
            time.sleep(0.5)

            print(
                f"Configuring Address: {address['AddressName']} {address['AddressIPAndSubnet']}"
            )
            print("Checking if Address already exists...")
            response = requests.request(
                "GET",
                FORTIGATE_URL + "/api/v2/cmdb/firewall/address/" + address["AddressName"],
                headers=headers,
                verify=SSL_VERIFY
            )
            print(response.status_code)
            output = response.json()

            # If Address does not exist, create it
            if response.status_code != 200:
                print("Address does not exist, creating address...")
                payload_dict = {}
                payload_dict["name"] = address["AddressName"]
                payload_dict["subnet"] = address["AddressIPAndSubnet"]
                print(f"Address Dictionary : {payload_dict}")

                payload = json.dumps(payload_dict)
                # Create Address
                response = requests.request(
                    "POST",
                    FORTIGATE_URL + "/api/v2/cmdb/firewall/address",
                    headers=headers,
                    data=payload,
                    verify=SSL_VERIFY
                )

                print(response.status_code)
                output = response.json()

                if "cli_error" in output:
                    print(f"CLI Error: {output['cli_error']}")

            # Checking if Address Group exits
            print("Checking if Address Group already exists...")
            response = requests.request(
                "GET",
                FORTIGATE_URL
                + "/api/v2/cmdb/firewall/addrgrp/"
                + address["AddressGroupName"],
                headers=headers,
                verify=SSL_VERIFY,
            )

            payload_dict = {}
            if response.status_code != 200:
                print("Group does not exist, creating group...")

                payload_dict["name"] = address["AddressGroupName"]
                payload_dict["member"] = [{"name": address["AddressName"]}]
                print(f"Group Dictionary : {payload_dict}")

                payload = json.dumps(payload_dict)
                response = requests.request(
                    "POST",
                    FORTIGATE_URL + "/api/v2/cmdb/firewall/addrgrp",
                    data=payload,
                    headers=headers,
                    verify=SSL_VERIFY,
                )
                print(response.status_code)
            else:
                print(
                    "Group does exist, checking if address is already a group member..."
                )
                results = response.json()
                ADDRESS_IS_NOT_MEMBER_OF_GROUP = True
                for member in results["results"][0]["member"]:
                    if member["name"] == address["AddressName"]:
                        ADDRESS_IS_NOT_MEMBER_OF_GROUP = False
                        break

                if ADDRESS_IS_NOT_MEMBER_OF_GROUP:
                    print(
                        "Group does exist, address is not already in group, adding group member..."
                    )
                    payload_dict["name"] = address["AddressName"]
                    payload = json.dumps(payload_dict)
                    response = requests.request(
                        "POST",
                        FORTIGATE_URL
                        + "/api/v2/cmdb/firewall/addrgrp/"
                        + address["AddressGroupName"]
                        + "/member",
                        data=payload,
                        headers=headers,
                        verify=SSL_VERIFY,
                    )

                print(response.status_code)

                output = response.json()
                if "cli_error" in output:
                    print(f"CLI Error: {output['cli_error']}")
