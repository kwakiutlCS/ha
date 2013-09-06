class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to filter_transactions_path({filter_category: session[:filter_category], date: session[:date], startDate: session[:startDate], endDate: session[:endDate]})
  end

  def create
    transaction_hash = Transaction.createTransaction(params[:transaction], current_user)
    transaction = current_user.transactions.build(transaction_hash)
    
    if transaction_hash == nil
      load_data(session)
      flash[:alert] = "Record couldn't be saved"
      respond_to do |format|
        format.html {render :index}
        format.js
      end
    
    elsif transaction.save 
      load_data(session)
      flash[:alert] = "Record saved"
      respond_to do |format|
        format.html {redirect_to transactions_path}
        format.js
      end
      
    else

      flash[:alert] = "Record couldn't be saved"
      load_data(session)
      @transaction = transaction
      respond_to do |format|
        format.html {render :index}
        format.js
      end
      
    end
  end

  
  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy
    load_data(session)
    
    respond_to do |format|
      format.html {redirect_to transactions_path}
      format.js {render :create}
    end
  end



  def edit
    load_data(session)
    @editable = current_user.transactions.find(params[:id])
    respond_to do |format|
      format.js 
    end
  end


  def update
    transaction_hash = Transaction.createTransaction(params[:transaction], current_user)
    transaction = current_user.transactions.find(params[:id])
    
    if transaction_hash == nil
      load_data(session)
      flash[:alert] = "Record couldn't be updated"
      respond_to do |format|
        format.html {render :index}
        format.js {render :create}
      end
    
    elsif transaction.update_attributes(transaction_hash)
      load_data(session)
      flash[:alert] = "Record updated"
      respond_to do |format|
        format.html {redirect_to transactions_path}
        format.js {render :create}
      end
      
    else

      flash[:alert] = "Record couldn't be updated"
      load_data(session)
      @transaction = transaction
      respond_to do |format|
        format.html {render :index}
        format.js {render :create}
      end
      
    end
  end





  def add_category
    load_data(session)
    current_user.addCategory(params[:category][:title], params[:category][:transaction_type])

    respond_to do |format|
      format.html {redirect_to transactions_path}
      format.js 
    end
  end

  def filter
    load_session(params)
    load_data(session)
    respond_to do |format|
      format.html {render :index}
      format.js {render :create}
    end
  end




  private 
  def load_data(params_hash)
    @revenues = current_user.transactions.where(transaction_type: true).order("date desc, category_id, value_cents desc")
    @expenses = current_user.getExpenses(params_hash)
    
    @total_expenses = Transaction.getTotal(@expenses)
    @total_revenues = Transaction.getTotal(@revenues)
    @category = current_user.categories.build
    @transaction = current_user.transactions.build
    @editable = current_user.transactions.build
  end



  def load_session(p)
    session[:filter_category] = p[:filter_category] if p[:filter_category]
    session[:filter_category] = "All" unless session[:filter_category]
    session[:date] = p[:date] if p[:date] 
    session[:date] = "month" unless session[:date]
    session[:startDate] = p[:startDate] if p[:startDate]
    session[:endDate] = p[:endDate] if p[:endDate]
    
  end
end
