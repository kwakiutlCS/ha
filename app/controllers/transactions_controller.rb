class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @transactions = current_user.transactions
    @transaction = current_user.transactions.build
  end

  def create
    transaction_hash = Transaction.createTransaction(params[:transaction], current_user)
    p transaction_hash
    transaction = current_user.transactions.build(transaction_hash)

    if transaction.save
      @transaction = current_user.transactions.build
      @transactions = current_user.transactions
      redirect_to transactions_path
    else

      flash[:alert] = "Record couldn't be saved"
      @transactions = current_user.transactions
      @transaction = transaction
      render :index
    end
  end
end
