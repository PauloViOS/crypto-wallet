namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Deletando DB...") { %x(rails db:drop) }

      show_spinner("Criando DB...") { %x(rails db:create) }

      show_spinner("Executando migrações...") { %x(rails db:migrate) }

      %x(rails dev:add_mining_types)

      %x(rails dev:add_coins)

    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
        {
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://w7.pngwing.com/pngs/65/309/png-transparent-bitcoin-com-cryptocurrency-logo-zazzle-bitcoin-text-trademark-logo-thumbnail.png",
          mining_type: MiningType.find_by!(acronym: "PoW")
        },
        {
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://banner2.cleanpng.com/20190418/rgf/kisspng-ethereum-portable-network-graphics-computer-icons-developers-icon-request-icon-ethereum-5cb941c1cb12b1.1213852915556448658318.jpg",
          mining_type: MiningType.all.sample
        },
        {
          description: "Dash",
          acronym: "DASH",
          url_image: "https://cdn.vectorstock.com/i/1000x1000/71/25/dash-coin-icon-vector-19477125.webp",
          mining_type: MiningType.all.sample
        },
        {
          description: "Iota",
          acronym: "IOT",
          url_image: "https://p7.hiclipart.com/preview/296/274/484/iota-cryptocurrency-logo-internet-of-things-tether-bitcoin.jpg",
          mining_type: MiningType.all.sample
        },
        {
          description: "ZCash",
          acronym: "ZEC",
          url_image: "https://thumbs.dreamstime.com/b/crypto-currency-golden-coin-black-lackered-zcash-symbol-obverse-transparent-background-vector-illustration-use-logos-100737091.jpg",
          mining_type: MiningType.all.sample
        }
      ]

      puts "Cadastrando moedas..."

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastro dos tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {
          description: "Proof of Work",
          acronym: "PoW"
        },
        {
          description: "Proof of Stake",
          acronym: "PoS"
        },
        {
          description: "Proof of Capacity",
          acronym: "PoC"
        }
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end="Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :pulse_2)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
