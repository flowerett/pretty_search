# encoding: utf-8
# Public: Реализует методы атрибутов и параметров поля,
# по которому осуществляется поиск.
#
# Examples
#
#   field.name => :title
#   field.model_class => Company
module PrettySearch
  class Field
    # Public: Задает/считывает имя, тип поля, и класс к которому поле относится.
    attr_accessor :name, :type, :model_class

    # Public: Инициализирует поле.
    #
    # model_class - Класс, по которому будет осуществляться поиск (обяз.).
    # field_name  - Строка с именем поля, по которому
    #               будет осуществлятсья поиск (необяз.).
    def initialize(model_class, field_name = nil)
      # Если поле не передано, пробуем стандартные, указанные в конфиге поля
      if field_name.nil?
        field_name = model_class.attribute_names.detect{ |v| PrettySearch.default_search_fields.include? v.to_sym }
      end

      unless field_name.nil?
        self.name        = field_name
        self.type        = model_class.columns_hash[name].type
        self.model_class = model_class
      end
    end

    # Public: Проверяет, разрешено ли искать записи по этому полю.
    #
    # Returns bool.
    def available_for_search?
      model_name = model_class.to_s.downcase.to_sym

      if PrettySearch.disabled_fields.any?
        if PrettySearch.disabled_fields.keys.include? model_name
          ([name.to_sym] & PrettySearch.disabled_fields[model_name]).none?
        else
          true
        end
      elsif PrettySearch.enabled_fields.any?
        if PrettySearch.enabled_fields.keys.include? model_name
          ([name.to_sym] - PrettySearch.enabled_fields[model_name]).none?
        else
          false
        end
      else
        true
      end
    end
  end
end
