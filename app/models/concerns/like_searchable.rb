module LikeSearchable
  extend ActiveSupport::Concern

  included do
    scope :like, -> (key, value) do
      self.where(self.arel_table[key].matches("%#{value}%"))
      #self.where("#{key} LIKE ?", "%#{value}%")
    end
  end
end

# self.where("#{key} ILIKE ?", "%#{value}%") acima qq banco de dados PostgreSql

      # utiliza o Active Record para NÃO ocorrer de passar "código malicioso"
      # .where("name LIKE '%#{params}%") problema segurança LIKE direto no params
      # .where("name LIKE '%%'; DELETE * FROM nome_tabela%") <<== Perigo Segurança

      # estamos prendendo a querie a uma tecnologia específica de Banco