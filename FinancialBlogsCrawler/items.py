# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class BlogsItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    blogger_name = scrapy.Field()
    headline = scrapy.Field()
    content = scrapy.Field()
    num_views = scrapy.Field()
    num_comments = scrapy.Field()
    created_date = scrapy.Field()
