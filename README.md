# WePager
WePager is a simple and easy to use data storage REST API service.
Data is stored in `project` which is consisted of alphabetic-only random id with unlimited `records` in json format.

## Usage
You must create a `project` first before you can store any data. See the `project` section.

### Create project
_TODO_

```POST /api/project```

 - ``record_expiry`` -- record expiry period, will delete any records older than the specified period, default to 7 days
 - ``project_expiry`` -- project expiry period, will delete proect and all records older than the specified expiry period, default to 2 months
 - auth_key -- optional, see `administation`.
 
```DELETE /api/project/p1bi1zpgetst```

### Saving record
```POST /api/p1bi1zpgetst/daily_log```
 
 - body -- json payload
 - meta_order -- optional integer value to indicate for sorting order, defaults to 0
 - meta_type -- optional string value to indicate record type
 - meta_name -- optional string value to indicate record name
  
where `p1bi1zpgetst` is the required project id and `daily_log` as the data type.

### Retrieving records
```GET /api/p1bi1zpgetst/daily_log```
will return the latest 50 records. Optional `start` and `size` to paginate result.

```GET /api/p1bi1zpgetst/daily_log/Jq6jIYvB8vn_9S~lEW_ksZATu1lgh7wo``` 
to retrive specific record.

### Delete records
```DELETE /api/p1bi1zpgetst/daily_log/Jq6jIYvB8vn_9S~lEW_ksZATu1lgh7wo``` 

## Configuration
_TODO_

 - admin password
 - project key size, defaults to 10 character 

## Setup
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### TODO
- [ ] Project
- [ ] Record
- [ ] Configuration
- [ ] Administration
- [ ] elixir task cli for admin tasks