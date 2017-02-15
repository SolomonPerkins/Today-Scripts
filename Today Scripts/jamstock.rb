require "json"
require 'net/http'

class String
    def green;          "\033[32m#{self}\033[0m" end
    def red;            "\033[31m#{self}\033[0m" end
    
    def bold;           "\e[1m#{self}\e[22m" end
    
    def bg_gray;        "\e[47m#{self}\e[0m" end
    def bg_black;       "\e[40m#{self}\e[0m" end
end
#file = File.open("jamstock.txt", 'r')
#symboll = file.read
#file.close

# symbols = symboll.split(',')
# symbols.each do |symbol|
url = 'https://www.jamstockex.com/wp-json/jse-api/v1/trades'
resp = Net::HTTP.get_response(URI.parse(url))
data = resp.body
hash = JSON.parse(data)
results = hash['data']['Instruments']
results.each do |unit|
    symbol = unit['Label']
    change = unit['Movement']
    percentChange = unit['Change']
    price = unit['Close']
    
    if change == 'up'
        puts "📈 #{symbol} | COST $#{price} | % CHANGE #{percentChange}".bold.green.bg_black
        puts "\n"
        else if change == 'down'
        puts "📉 #{symbol} | COST $#{price} | % CHANGE #{percentChange}".bold.red.bg_black
        puts "\n"
        else
        
        puts "❄️ #{symbol} | COST $#{price} | % CHANGE #{percentChange}".bold.bg_black
        puts "\n"
    end
end
end
