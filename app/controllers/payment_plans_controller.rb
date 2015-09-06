class PaymentPlansController < ApplicationController
  # GET /payment_plans
  # GET /payment_plans.json
  def index
    @payment_plans = PaymentPlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_plans }
    end
  end

  # GET /payment_plans/1
  # GET /payment_plans/1.json
  def show
    @payment_plan = PaymentPlan.find(params[:id])
    @payments=@payment_plan.payments
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_plan }
    end
  end

  # GET /payment_plans/new
  # GET /payment_plans/new.json
  def new
    @payment_plan = PaymentPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment_plan }
    end
  end

  # GET /payment_plans/1/edit
  def edit
    @payment_plan = PaymentPlan.find(params[:id])
  end

  # POST /payment_plans
  # POST /payment_plans.json
  def create
    puts(params[:payment_plan][:birthDate])
    @credit=CreditLine.find(params[:payment_plan][:credit_line])
    @admin=Admin.find(@credit.admin_id)

    par=params[:payment_plan]
    date = Date.new(par["birthDate(1i)"].to_i, par["birthDate(2i)"].to_i, par["birthDate(3i)"].to_i)

    @payment_plan =@admin.payment_plans.new(birthDate: date, identification: par[:identification], numberOfPayments: par[:numberOfPayments], principal: par[:principal], riskLevel: par[:riskLevel], state: par[:state])
    @payment_plan.assign_attributes({ :CreditLine_id => @credit.id})
    @payment_plan.assign_attributes({ :state => 'In progress'})

    #@payment_plan = PaymentPlan.new(params[:payment_plan])
   #@payment_plan.credit_line=@credit
    puts(@payment_plan.to_s)
    respond_to do |format|
      if @payment_plan.save
        format.html { redirect_to @payment_plan, notice: 'Payment plan was successfully created.' }
        format.json { render json: @payment_plan, status: :created, location: @payment_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @payment_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payment_plans/1
  # PUT /payment_plans/1.json
  def update
    @payment_plan = PaymentPlan.find(params[:id])

    respond_to do |format|
      if @payment_plan.update_attributes(params[:payment_plan])
        format.html { redirect_to @payment_plan, notice: 'Payment plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_plans/1
  # DELETE /payment_plans/1.json
  def destroy
    @payment_plan = PaymentPlan.find(params[:id])
    @payment_plan.destroy

    respond_to do |format|
      format.html { redirect_to payment_plans_url }
      format.json { head :no_content }
    end
  end


  def self.calculation
    tiempoInicial=Time.now
    t=PaymentPlan.find_by_state('In progress')
    credit=CreditLine.find(t.CreditLine_id)
    if(t.nil?)

    else
        cuotaAmortizacion=(t.principal/t.numberOfPayments)
        capitalVivo=t.principal #-AMORTIZACION
        interes=capitalVivo*(credit.interest_rate/100)
        payment=t.payments.new(paymentNumber: 0, paymentInterest: 0, paymentAmortization: 0, pendingBalance: capitalVivo, totalPayment:0)
        payment.save
        cont=0
        totalPagado=0
        capitalVivo=t.principal
        while cont.to_i < t.numberOfPayments
          cont= cont.to_i+1

          capitalVivo=capitalVivo-cuotaAmortizacion
          interes=capitalVivo*(credit.interest_rate/100)
          amort=cuotaAmortizacion + interes.abs
          totalPagado=totalPagado+(amort.abs)
          payment=t.payments.new(paymentNumber: cont, paymentInterest: interes, paymentAmortization: cuotaAmortizacion, pendingBalance: capitalVivo, totalPayment:totalPagado)
          payment.save
        end
        risk=0
        while Time.now.sec - tiempoInicial.sec<25
          risk=rand(10)
        end
        puts(risk)
        t.update_attribute(:riskLevel,risk)

      t.update_attribute(:state, 'Completed')
      t.save
    end
    puts(t.id)
  end
end
