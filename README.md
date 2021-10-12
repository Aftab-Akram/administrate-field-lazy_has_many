# Administrate::Field::LazyHasMany

[![Gem Downloads](http://img.shields.io/gem/dt/administrate-field-lazy_has_many.svg)](https://rubygems.org/gems/administrate-field-lazy_has_many) [![Gem Version](https://badge.fury.io/rb/administrate-field-lazy_has_many.png)](http://badge.fury.io/rb/administrate-field-lazy_has_many) [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

An input field that shows search results of has many association, lazily from a custom endpoint.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate-field-lazy_has_many'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install administrate-field-lazy_has_many

## Usage

### Controller
You need to have a route that does the following:
1. yields an array of objects with at least the value and text you want to show i.e `[{value: 1, text: option1}]`
2. Respond to `search` attribute
3. Limit result `result_limit`

The best way is to re-use everything administrate search feature.
You must define this action in administrate related entity  controller
```ruby
     def books_data
      result_limit = params[:result_limit] || 10
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource, dashboard_class, search_term).run
      resources = resources.limit(result_limit).map do |resource|
        { value: resource.id, text: dashboard.display_resource(resource) }
      end
      if resources.blank?
        render_empty_array
      else
        render json: resources
      end
    end
```
Above example action that could work for every model, but you can change the implementation as per need.
The only catch is it must return the comply with above conditions.

### Field
Field is pretty easy and it does support all the features of administrate has_many field. You can provide all has_many options as per your use case.
The only require attribute is `action` which must be rails path helper.
```ruby
require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::String,
    title: Field::String,
    contributors: Field::LazyHasMany.with_options(
      action: 'admin_form_contributors_data_path', result_limit: 10
    ),
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # ...
end
```
i.e `result_limit` attribute maximum result value the field will post to action endpoint with `search` paramter

## Contributing

1. Fork it ( https://github.com/Aftab-Akram/administrate-field-lazy_has_many )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
