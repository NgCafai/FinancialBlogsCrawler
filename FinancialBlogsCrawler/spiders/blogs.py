# -*- coding: utf-8 -*-
import scrapy
from ..items import *


class BlogsSpider(scrapy.Spider):
    name = 'blogs'
    allowed_domains = ['blog.eastmoney.com']

    def start_requests(self):
        for page in range(1, 32):
            url = 'http://blog.eastmoney.com/yuyuetong/bloglist_0_%d.html' % page
            self.logger.debug('parsing page: ' + url)
            yield scrapy.Request(url, callback=self.parse_outer_page)

    def parse_outer_page(self, response):
        detail_page_urls = response.css("#emblog_list > div.list > ul > li > a::attr(href)").extract()
        for url in detail_page_urls:
            yield scrapy.Request(url, callback=self.parse_detail_page)

    def parse_detail_page(self, response):
        if response.status != 200:
            self.logger.debug('fails when crawl ' + response.url + ' ' + response.status)
        blogger_name = response.css("#bloger > div.blognick > span > a::text").extract_first().strip()
        headline = response.xpath(
            '//*[@id="eb_content"]/div[2]/div/div[1]/div[2]/div/div[1]/text()').extract_first().strip()
        content = '\n'.join(
            [p.strip() for p in response.css('#articleBody > p > font::text').extract() if p.strip() != ''])
        num_views = response.css('#blog_view::text').extract_first()
        num_comments = response.css('#blog_review::text').extract_first()
        created_date = response.css('#eb_content > div.eb_column3 > div > '
                                    'div.compontent3 > div.compontentCo > div '
                                    '> div.articleTitle > span::text').re_first('\((.*)\)')

        item = BlogsItem()
        item["blogger_name"] = blogger_name
        item["headline"] = headline
        item['content'] = content
        item['num_views'] = num_views
        item['num_comments'] = num_comments
        item['created_date'] = created_date
        yield item
