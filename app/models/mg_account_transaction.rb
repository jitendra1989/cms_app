class MgAccountTransaction < ActiveRecord::Base
	def self.add_transaction(from_account_id,to_account_id,amount,for_module,particular_id,transaction_type,amount_transfer_type,school_id,created_by,updated_by)
		transaction=MgAccountTransaction.new(
				:mg_from_account_id=>from_account_id,
				:mg_to_account_id=>to_account_id,
				:current_date=>Date.today,
				:for_module=>for_module,
				:mg_particular_id=>particular_id,
				:is_deleted=>0,
				:mg_school_id=>school_id,
				:created_by=>created_by,
				:updated_by=>updated_by,
				:amount=>amount,
				:transaction_type=>transaction_type,
				:amount_transfer_type=>amount_transfer_type
			)
	end

	def self.add_canteen_transaction(particular_id,to_account_id,amount,school_id,created_by,updated_by)
		transaction=MgAccountTransaction.new(
				# :mg_from_account_id=>from_account_id,
				:mg_to_account_id=>to_account_id,
				:amount=>amount,
				:current_date=>Date.today,
				:for_module=>'canteen_managements',
				:mg_particular_id=>particular_id,
				# :transaction_type=>'payable',
				:amount_transfer_type=>'credited',
				:mg_school_id=>school_id,
				:created_by=>created_by,
				:updated_by=>updated_by,
				:is_deleted=>0
			)
	end


	def self.add_canteen_updated_transaction(amount_transfer_type,particular_id,to_account_id,amount,school_id,created_by,updated_by)
		transaction=MgAccountTransaction.new(
				# :mg_from_account_id=>from_account_id,
				:mg_to_account_id=>to_account_id,
				:amount=>amount,
				:current_date=>Date.today,
				:for_module=>'canteen_managements',
				:mg_particular_id=>particular_id,
				# :transaction_type=>'payable',
				:amount_transfer_type=>amount_transfer_type,
				:mg_school_id=>school_id,
				:created_by=>created_by,
				:updated_by=>updated_by,
				:is_deleted=>0
			)
	end

	def self.add_sports_transaction(particular_id,to_account_id,amount,school_id,created_by,updated_by)
		transaction=MgAccountTransaction.new(
				# :mg_from_account_id=>from_account_id,
				:mg_to_account_id=>to_account_id,
				:amount=>amount,
				:current_date=>Date.today,
				:for_module=>'sports_managements',
				:mg_particular_id=>particular_id,
				# :transaction_type=>'payable',
				:amount_transfer_type=>'credited',
				:mg_school_id=>school_id,
				:created_by=>created_by,
				:updated_by=>updated_by,
				:is_deleted=>0
			)
	end


	def self.add_sports_updated_transaction(amount_transfer_type,particular_id,to_account_id,amount,school_id,created_by,updated_by)
		transaction=MgAccountTransaction.new(
				# :mg_from_account_id=>from_account_id,
				:mg_to_account_id=>to_account_id,
				:amount=>amount,
				:current_date=>Date.today,
				:for_module=>'sports_managements',
				:mg_particular_id=>particular_id,
				# :transaction_type=>'payable',
				:amount_transfer_type=>amount_transfer_type,
				:mg_school_id=>school_id,
				:created_by=>created_by,
				:updated_by=>updated_by,
				:is_deleted=>0
			)
	end


end
