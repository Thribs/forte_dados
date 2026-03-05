<style scoped>
main {
  font-family: Arial, sans-serif;
  background-color: #f5f5f5;
  color: #333;
}

.container.busca {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
}

.container.busca label.cnpj {
  font-size: 18px;
  margin-bottom: 10px;
}

.container.busca input.campo.cnpj {
  margin-top: 20px;
  padding: 10px;
  width: 300px;
  font-size: 16px;
}

.container.busca button.confirmar {
  margin-top: 20px;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
}

.container.resultado {
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px;
}
.container.resultado h2 {
  font-size: 24px;
  margin-bottom: 20px;
}

.container.resultado ul {
  list-style-type: none;
  padding: 0;
}
.container.resultado ul li {
  font-size: 18px;
  margin-bottom: 10px;
}

.container.resultado button {
  margin-top: 20px;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
}

.container.resultado .container.acoes button {
  margin-right: 10px;
}

</style>

<script>
const EstadoBusca = Object.freeze({
  aguardando: 'aguardando',
  buscando: 'buscando',
  concluido: 'concluido',
})

const ModoResultado = Object.freeze({
  caracteristicas: 'caracteristicas',
  seo: 'seo',
  concorrentes: 'concorrentes',
  fornecedores: 'fornecedores',
  publicoAlvo: 'publicoAlvo',
})

export default {
  name: 'forte',
  data() {
    return {
      estadoBusca: EstadoBusca.aguardando,
      modoResultado: ModoResultado.caracteristicas,
      cnpj: '',
      empresa: null,
      concorrentes: [],
      EstadoBusca,
      ModoResultado,
    }
  },
  methods: {
    buscarEmpresa() {
      // Lógica para buscar a empresa pelo CNPJ
      // Exemplo de resposta simulada
      this.empresa = {
        cnpj: '12.345.678/0001-90',
        categoria: 'Exemplo',
        razaoSocial: 'Exemplo S.A.',
        nomeFantasia: 'Exemplo',
        endereco: 'Rua Exemplo, 123 - São Paulo/SP',
        capitalSocial: 'R$ 1.000.000',
      }
      this.estadoBusca = EstadoBusca.concluido
    },
    buscarConcorrentes() {
      // Lógica para buscar concorrentes da empresa
      // Exemplo de resposta simulada
      this.modoResultado = ModoResultado.concorrentes
      this.concorrentes = [
        { nome: 'Concorrente 1', cnpj: '98.765.432/0001-10' },
        { nome: 'Concorrente 2', cnpj: '87.654.321/0001-20' },
      ]
    },
  },
}

</script>

<template>
  <main>
    <div class="container busca">
      <label for="cnpj-busca" class="cnpj">Digite o seu CNPJ ou de um concorrente para começar</label>
      <input type="text" id="cnpj-busca" class="campo cnpj" placeholder="CNPJ">
      <button class="confirmar" @click="buscarEmpresa">Buscar</button>
    </div>
  
    <div class="container resultado" v-if="estadoBusca === EstadoBusca.concluido">
      <div v-if="modoResultado === ModoResultado.caracteristicas">
        <h2>características da empresa</h2>
        <ul>
          <li>CNPJ: 12.345.678/0001-90</li>
          <li>Categoria: Exemplo</li>
          <li>Razão Social: Exemplo S.A.</li>
          <li>Nome Fantasia: Exemplo</li>
          <li>Endereço: Rua Exemplo, 123 - São Paulo/SP</li>
          <li>Capital Social: R$ 1.000.000</li>
        </ul>
        <div class="container acoes">
          <button class="buscar-concorrentes" @click="buscarConcorrentes">buscar concorrentes</button>
          <button class="verificar-posicao-SEO" @click="verificarPosicaoSEO" disabled>verificar competitividade em busca online</button>
          <button class="buscar-fornecedores" @click="buscarFornecedores" disabled>buscar fornecedores</button>
          <button class="analisar-publico-alvo" @click="analisarPublicoAlvo" disabled>analisar público-alvo</button>
        </div>
      </div>
      <div v-if="modoResultado === ModoResultado.concorrentes">
        <h2>possíveis concorrentes</h2>
        <button class="filtrar" disabled>filtrar</button>
        <ul>
          <li v-for="concorrente in concorrentes" :key="concorrente.cnpj">
            {{ concorrente.nome }} - CNPJ: {{ concorrente.cnpj }}
            <button class="mais-informacoes" disabled>mais informações</button>
          </li>
        </ul>
        <button class="voltar" @click="modoResultado = ModoResultado.caracteristicas">voltar</button>
      </div>
      <div v-if="modoResultado === ModoResultado.seo">
        <h2>competitividade em busca online</h2>
        <button class="filtrar" disabled>filtrar</button>
        <ul>
          <li>Concorrente 1 - Posição: 5º lugar</li>
          <li>Concorrente 2 - Posição: 10º lugar</li>
        </ul>
        <button class="voltar" @click="modoResultado = ModoResultado.caracteristicas">voltar</button>
      </div>
      <div v-if="modoResultado === ModoResultado.fornecedores">
        <h2>fornecedores</h2>
        <button class="filtrar" disabled>filtrar</button>
        <ul>
          <li>Fornecedor 1 - CNPJ: 11.111.111/0001-11</li>
          <li>Fornecedor 2 - CNPJ: 22.222.222/0001-22</li>
        </ul>
        <button class="voltar" @click="modoResultado = ModoResultado.caracteristicas">voltar</button>
      </div>
      <div v-if="modoResultado === ModoResultado.publicoAlvo">
        <h2>publico-alvo</h2>
        <button class="filtrar" disabled>filtrar</button>
        <ul>
          <li>
            <h3>madeireiras</h3>
            <p>Empresas que atuam no setor de madeireiras, fornecendo produtos relacionados à madeira, como tábuas, vigas, compensados, entre outros. Essas empresas podem ser potenciais clientes para a empresa em questão, dependendo do tipo de produto ou serviço que ela oferece.</p>
            <button class="buscar-clientes" disabled>possíveis clientes</button>
          </li>
          <li>
            <h3>construtoras</h3>
            <p>Empresas que atuam no setor de construção civil, fornecendo serviços e produtos relacionados à construção, como materiais de construção, equipamentos, entre outros. Essas empresas podem ser potenciais clientes para a empresa em questão, dependendo do tipo de produto ou serviço que ela oferece.</p>
            <button class="buscar-clientes" disabled>possíveis clientes</button>
          </li>
        </ul>
        <button class="voltar" @click="modoResultado = ModoResultado.caracteristicas">voltar</button>
      </div>
    </div>
  </main>
  
</template>
