class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @revenues = current_user.transactions.where(transaction_type: true)
    @expenses = current_user.transactions.where(transaction_type: false)
    @transaction = current_user.transactions.build
  end

  def create
    transaction_hash = Transaction.createTransaction(params[:transaction], current_user)
    p transaction_hash
    transaction = current_user.transactions.build(transaction_hash)

    if transaction.save
      @transaction = current_user.transactions.build
      @revenues = current_user.transactions.where(transaction_type: true)
      @expenses = current_user.transactions.where(transaction_type: false)
    
      redirect_to transactions_path
    else

      flash[:alert] = "Record couldn't be saved"
      @revenues = current_user.transactions.where(transaction_type: true)
      @expenses = current_user.transactions.where(transaction_type: false)
    
      @transaction = transaction
      render :index
    end
  end
end
