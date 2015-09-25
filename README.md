# lita-salesforce

[![Build Status](https://travis-ci.org/chulkilee/lita-salesforce.svg?branch=master)](https://travis-ci.org/chulkilee/lita-salesforce)
[![Coverage Status](https://coveralls.io/repos/chulkilee/lita-salesforce/badge.svg?branch=master&service=github)](https://coveralls.io/github/chulkilee/lita-salesforce?branch=master)

a [lita](https://www.lita.io/) handler that talks to [Salesforce](https://www.salesforce.com/)

## Installation

Add lita-salesforce to your Lita instance's Gemfile:

``` ruby
gem 'lita-salesforce'
```

## Configuration

Set ENV variables for [restforce](https://github.com/ejholmes/restforce).

```
export SALESFORCE_USERNAME="username"
export SALESFORCE_PASSWORD="password"
export SALESFORCE_SECURITY_TOKEN="security token"
export SALESFORCE_CLIENT_ID="client id"
export SALESFORCE_CLIENT_SECRET="client secret"
```

## Usage

```
Lita > salesforce contract ...
ContractNumber: ...
Status: ...
StartDate: ...
EndDate: ...
Description:
SpecialTerms:
Account.Id: ...
Account.Name: ...
Owner.Name: ...
```
