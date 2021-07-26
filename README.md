# dyn-api-gen
Dynamic API client generator. Aims to follow OpenAPI + JSON API standards


# Usage (WIP)


```ruby
ApiClient = DynApiGen::Generator.generate('./swagger/v1/openapi.yaml')

request =
  EmancuApiClient::SalesmatchingMakeAliases
    .delete_salesmatching_make_alias
    .with_headers
    .with_dealership_id(5)
    .with_page_size(4)
    .with_filter_deal_type('some,valid,filters')

# EmancuApiClient.send_request(request, with_jwt: '123')

```
