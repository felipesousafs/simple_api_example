# Simple HTML Page parser API
Simple API made with Ruby on Rails + [jsonapi_resources gem](https://github.com/cerebris/jsonapi-resources).

**Ruby version**: 2.5.3

**Rails version**: 5.2.2

**Database**: PostgreSQL 10.7

## About the code

##### What tools did I use?

* [Open-uri](https://www.rubydoc.info/stdlib/open-uri/OpenURI) to HTTP requests
* [Nokogiri](http://nokogiri.org) for HTML parsing

##### How?

```ruby
# We need open-uri to get the html page
require 'open-uri'
# Fetch and parse HTML document
doc = Nokogiri::HTML(open(PAGE_LINK_ATTRIBUTE))

# Use CSS Selector to get only the H1, H2 and H3 elements from the HTML page
doc.css('h1', 'h2', 'h3').each do |header|
  content_type = ContentType.find_or_create_by(name: header.name) # Find or create the content type (H1, H2 or H3)
  contents.create(content_type: content_type, text: header.text) # Store the element content
end

# Use CSS Selector to get all links on the page
doc.css('link[href]').each do |element|
  urls.create(link: element['href']) # Store only the URL in our database
end
```

## Preparation

##### Install Dependencies

```shell
$ bundle install
```


## Running 
```shell
$ rails server
```

## Queries

- `[POST] /pages`
  - You must provide a json data with value for the **link** attribute (Page URL) and the **type** 'pages', like you can see in the following example
  
      ```json
      {
        "data": {
          "type": "pages",
          "attributes": {
            "link": "https://www.github.com"
          }
        }
      }
      
      ```
- `[GET] /pages`
  - You call it without any params. Retrieve data from all stored "pages", with their *contents* (h1, h2 and h3) and *urls*
        
    You will get a response like this:
      ```json
      {
        "data": [
          {
            "id": "20",
            "type": "pages",
            "links": {
              "self": "http://localhost:3000/pages/20"
            },
            "attributes": {
              "link": "https://www.github.com"
            },
            "relationships": {
              "urls": {
                "links": {
                  "self": "http://localhost:3000/pages/20/relationships/urls",
                  "related": "http://localhost:3000/pages/20/urls"
                }
              },
              "contents": {
                "links": {
                  "self": "http://localhost:3000/pages/20/relationships/contents",
                  "related": "http://localhost:3000/pages/20/contents"
                }
              }
            }
          }
        ]
      }
      
      ```
  - You can also provide params.
  
    - `[GET] /pages?include=urls,contents`
  
    You will get a response like this:
    ```json
     {
       "data": [
         {
           "id": "20",
           "type": "pages",
           "links": {
             "self": "http://localhost:3000/pages/20"
           },
           "attributes": {
             "link": "https://www.github.com"
           },
           "relationships": {
             "urls": {
               "links": {
                 "self": "http://localhost:3000/pages/20/relationships/urls",
                 "related": "http://localhost:3000/pages/20/urls"
               },
               "data": [
                 {
                   "type": "urls",
                   "id": "15"
                 },
                 {
                   "type": "urls",
                   "id": "16"
                 },
                 {
                   "type": "urls",
                   "id": "17"
                 }
               ]
             },
             "contents": {
               "links": {
                 "self": "http://localhost:3000/pages/20/relationships/contents",
                 "related": "http://localhost:3000/pages/20/contents"
               },
               "data": [
                 {
                   "type": "contents",
                   "id": "31"
                 },
                 {
                   "type": "contents",
                   "id": "32"
                 }
               ]
             }
           }
         }
       ],
       "included": [
         {
           "id": "1",
           "type": "urls",
           "links": {
             "self": "http://localhost:3000/urls/1"
           },
           "attributes": {
             "link": "https://nokogiri.org/index.html"
           }
         },
         {
           "id": "2",
           "type": "urls",
           "links": {
             "self": "http://localhost:3000/urls/2"
           },
           "attributes": {
             "link": "images/nokogiri-serif-black.png"
           }
         },
         {
           "id": "18",
           "type": "contents",
           "links": {
             "self": "http://localhost:3000/contents/18"
           },
           "attributes": {
             "text": "Links¶"
           },
           "relationships": {
             "content-type": {
               "links": {
                 "self": "http://localhost:3000/contents/18/relationships/content-type",
                 "related": "http://localhost:3000/contents/18/content-type"
               }
             }
           }
         },
         {
           "id": "19",
           "type": "contents",
           "links": {
             "self": "http://localhost:3000/contents/19"
           },
           "attributes": {
             "text": "Status¶"
           },
           "relationships": {
             "content-type": {
               "links": {
                 "self": "http://localhost:3000/contents/19/relationships/content-type",
                 "related": "http://localhost:3000/contents/19/content-type"
               }
             }
           }
         }
       ]
     }
       ```