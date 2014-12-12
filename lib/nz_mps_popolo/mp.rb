module NZMPsPopolo
  class MP
    attr_reader :entry_id, :first_names, :last_name, :party,
                :electorate, :list, :details_url

    def initialize(options)
      @entry_id                = options.fetch(:entry_id)
      @first_names, @last_name = options.fetch(:first_names), options.fetch(:last_name)
      @party                   = options.fetch(:party)
      @electorate, @list       = options[:electorate], options.fetch(:list)
      @details_url             = options[:details_url]
    end
  end
end
