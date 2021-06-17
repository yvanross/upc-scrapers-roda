class Strategy
    # @abstract

    def scrape(code)
        raise NotImplementedError  "#{self.class} has not implemented method '#{__method__}'"
    end 
end
