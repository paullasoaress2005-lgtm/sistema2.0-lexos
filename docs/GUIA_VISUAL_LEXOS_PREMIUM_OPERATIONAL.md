# Guia Visual Reutilizavel - LEX.OS Premium Operational

## Finalidade

Este documento descreve a linguagem visual utilizada no LEX.OS Cartorio Control para que ela possa ser aplicada em outros sistemas da LEX.OS.

O objetivo nao e copiar telas ou funcionalidades do Cartorio Control. O objetivo e reproduzir a mesma percepcao de marca:

- premium;
- sobria;
- institucional;
- tecnologica sem parecer futurista demais;
- organizada para uso operacional diario;
- compacta, confortavel e confiavel.

## Conceito Visual

A interface deve parecer uma central operacional madura, utilizada diariamente por profissionais. Ela nao deve parecer uma landing page, um chatbot, uma planilha ou um dashboard SaaS generico.

Palavras que orientam o design:

- precisao;
- governanca;
- confianca;
- calma;
- densidade controlada;
- hierarquia;
- rastreabilidade;
- tecnologia assistiva;
- responsabilidade humana.

## Principios Permanentes

1. Use fundo escuro navy/ink, nunca preto puro como superficie principal.
2. Use dourado com moderacao para institucionalidade e acoes importantes.
3. Use cyan para tecnologia, informacao assistida e elementos operacionais.
4. Use prata e off-white para leitura.
5. Reserve verde, vinho e vermelho para estados semanticos.
6. Use bordas sutis para separar superficies.
7. Evite cards gigantes e espacos vazios excessivos.
8. Prefira conteudo alinhado a largura util da pagina.
9. Mantenha textos objetivos e hierarquia facil de escanear.
10. Toda interacao deve ter hover, foco visivel e feedback claro.

## Paleta De Cores

### Fundos E Superficies

| Token sugerido | RGB | Hex aproximado | Uso |
| --- | --- | --- | --- |
| `ink` | `5 14 27` | `#050E1B` | Fundo profundo, campos e areas internas |
| `navy` | `9 24 43` | `#09182B` | Sidebar, topbar e superficies institucionais |
| `panel` | `15 34 57` | `#0F2239` | Cards principais e paineis |
| `card` | `19 41 66` | `#132942` | Cards internos e linhas destacadas |
| `line` | `43 66 94` | `#2B425E` | Bordas e divisorias |

### Texto E Destaque

| Token sugerido | RGB | Hex aproximado | Uso |
| --- | --- | --- | --- |
| `silver` | `222 229 238` | `#DEE5EE` | Texto principal |
| `muted` | `148 165 186` | `#94A5BA` | Texto secundario e metadados |
| `gold` | `202 165 91` | `#CAA55B` | Acoes principais e estado ativo |
| `goldSoft` | `237 208 145` | `#EDD091` | Texto dourado e destaques suaves |
| `cyan` | `92 201 213` | `#5CC9D5` | Tecnologia, informacao e assistencia |
| `green` | `87 169 130` | `#57A982` | Sucesso e conclusao |
| `wine` | `148 57 75` | `#94394B` | Risco institucional |
| `red` | `211 102 111` | `#D3666F` | Erro ou risco alto |

### Gradiente De Fundo

```css
background:
  radial-gradient(circle at 12% -8%, rgba(92, 201, 213, 0.10), transparent 30rem),
  radial-gradient(circle at 88% 0%, rgba(202, 165, 91, 0.09), transparent 32rem),
  linear-gradient(180deg, #050e1b 0%, #081425 52%, #050c17 100%);
```

O brilho deve ser quase imperceptivel. Evite neon, orbes grandes e gradientes coloridos agressivos.

## Tipografia

Utilize tres funcoes tipograficas:

| Funcao | Sugestao | Uso |
| --- | --- | --- |
| Sans-serif | `Manrope`, `Inter`, sistema | Interface, cards, botoes e textos |
| Serif | `Newsreader`, `Georgia` | Titulos principais e numeros institucionais |
| Monoespacada | `DM Mono`, `Consolas` | Eyebrows, codigos, datas e metadados |

### Hierarquia Recomendada

- Titulo principal: serif, `30px` a `36px`, peso semibold.
- Titulo de card: sans-serif, `13px` a `15px`, peso extrabold.
- Texto principal: `12px` a `14px`, entrelinha confortavel.
- Texto secundario: `10px` a `12px`.
- Eyebrow e metadados: mono, `8px` a `10px`, caixa alta e letter-spacing amplo.
- Botoes: `11px` a `14px`, peso bold ou extrabold.

Textos menores fazem parte da densidade visual, mas nunca devem comprometer a leitura.

## Estrutura Geral

### Shell Desktop

- Sidebar fixa a esquerda com aproximadamente `232px`.
- Topbar sticky.
- Conteudo principal com largura maxima aproximada de `1500px`.
- Padding lateral de `32px` em desktop.
- Conteudo alinhado a largura util; nao centralize paineis internos mais estreitos sem razao.

### Shell Mobile

- Sidebar escondida.
- Navegacao principal em faixa horizontal rolavel abaixo da topbar.
- Padding lateral entre `16px` e `24px`.
- Cards e listas viram uma coluna.
- Badges e acoes podem quebrar para a linha seguinte.
- Nenhum conteudo deve gerar overflow horizontal da pagina.

## Superficies

### Superficie Principal

```css
border-radius: 16px;
border: 1px solid rgba(43, 66, 94, 0.70);
background: rgba(15, 34, 57, 0.80);
box-shadow: 0 24px 76px rgba(0, 0, 0, 0.30);
```

Adicionar um gradiente branco extremamente discreto no canto superior pode melhorar a profundidade.

### Superficie Interna

```css
border-radius: 12px;
border: 1px solid rgba(43, 66, 94, 0.60);
background: rgba(19, 41, 66, 0.50);
```

### Hover

- Alterar levemente a borda para dourado.
- Aumentar discretamente a opacidade da superficie.
- Aplicar sombra suave.
- Nunca usar zoom ou animacao chamativa.

## Espacamento E Proporcao

- Escala principal: `4px`, `8px`, `12px`, `16px`, `20px`, `24px`, `32px`.
- Gap entre cards: `12px` a `20px`.
- Padding de cards compactos: `16px`.
- Padding de cards importantes: `20px` a `24px`.
- Border radius: `12px` para elementos internos e `16px` para superficies principais.
- Linhas operacionais devem ter pelo menos `16px` de padding vertical.
- Use altura consistente entre cards da mesma grade.

## Componentes Visuais Fundamentais

### Cabecalho De Pagina

Estrutura:

1. eyebrow monoespacada;
2. titulo serif;
3. descricao curta;
4. acao opcional alinhada a direita;
5. linha inferior sutil.

O cabecalho deve ser compacto e institucional, sem aparencia de hero comercial.

### Sidebar

- Fundo navy levemente translucido.
- Grupos em caixa alta, mono, com letter-spacing.
- Item ativo com borda dourada discreta, fundo dourado quase transparente e marcador vertical.
- Icones lineares, simples e consistentes.
- Rodape com aviso institucional ou operacional.

### Cards De Modulo

- Icone em bloco cyan discreto.
- Badge de status no canto oposto.
- Titulo forte.
- Descricao curta.
- Acao separada por borda superior.
- Toda a area pode ser clicavel quando fizer sentido.

### Listas Operacionais

- Usar container de largura integral da area util.
- Cabecalho de colunas discreto em mono.
- Cada linha deve ser um card interno com borda propria.
- Distribuir colunas com grid e gaps controlados.
- Evitar `justify-content: space-between` quando espalhar demais o conteudo.
- No mobile, converter colunas em blocos com labels visiveis.

### Badges

```css
display: inline-flex;
align-items: center;
justify-content: center;
min-height: 28px;
padding: 6px 12px;
border-radius: 999px;
white-space: nowrap;
font-weight: 800;
```

Regras semanticas:

- dourado: pendencia, revisao e atencao;
- cyan: informacao e assistencia;
- verde: concluido ou ativo;
- vermelho/vinho: risco alto;
- navy/muted: desativado ou em preparacao.

### Botoes

Primario:

- fundo dourado;
- texto ink;
- peso forte;
- hover para dourado claro.

Secundario:

- fundo navy;
- borda discreta;
- texto silver;
- hover com borda dourada.

Estados disabled devem parecer indisponiveis e explicar o motivo quando necessario.

### Avisos E Governanca

- Fundo sutilmente dourado ou cyan.
- Icone em bloco.
- Titulo pequeno em caixa alta.
- Texto explicativo curto.
- Evitar vermelho para avisos que nao sejam realmente criticos.

### Linha Do Tempo

- Linha vertical discreta.
- Pontos cyan ou dourado.
- Data e setor em mono.
- Evento em texto forte.
- Status alinhado a direita no desktop.

### Fluxos E Etapas

- Stepper horizontal com rolagem interna quando necessario.
- Etapa atual em dourado.
- Etapas concluidas em verde.
- Etapas futuras em muted.
- Nao permitir que o stepper cause overflow da pagina.

## Responsividade

### Desktop Amplo

- Usar a largura util disponivel.
- Limitar apenas o container principal, nao cada painel interno.
- Grades com duas, tres ou quatro colunas conforme a complexidade.

### Notebook

- Reduzir numero de colunas progressivamente.
- Preservar gaps e paddings.
- Evitar textos e badges comprimidos.

### Mobile

- Uma coluna.
- Navegacao horizontal rolavel.
- Acoes podem ocupar largura integral.
- Tabelas convertidas em cards verticais.
- Metadados recebem labels.
- Badges quebram para outra linha sem sobreposicao.

## Microinteracoes

- Transicoes entre `150ms` e `250ms`.
- Hover suave em cards, botoes e links.
- Foco visivel com anel dourado.
- Icones de seta podem deslocar `2px` a `4px`.
- Menus flutuantes precisam de fundo opaco suficiente.
- Feedbacks de acao devem informar claramente o que ocorreu.

## O Que Evitar

- visual de chatbot;
- dashboard SaaS generico;
- cards enormes com pouco conteudo;
- areas vazias excessivas;
- paineis internos estreitos e centralizados sem necessidade;
- excesso de blur, glow ou neon;
- gradientes coloridos chamativos;
- icones juridicos obvios como martelo, balanca e tribunal;
- cores agressivas sem funcao semantica;
- textos pequenos demais;
- badges colados ou sobrepostos;
- layout desktop simplesmente comprimido no mobile;
- aparencia de automacao decisoria quando o sistema e assistivo.

## Checklist De Aceite Visual

- [ ] O sistema parece institucional e maduro.
- [ ] O fundo escuro tem profundidade sem chamar mais atencao que o conteudo.
- [ ] A hierarquia da pagina e compreendida rapidamente.
- [ ] Cards da mesma grade possuem proporcao consistente.
- [ ] Paineis acompanham a largura util normal da pagina.
- [ ] Textos, badges e botoes nao se sobrepoem.
- [ ] Estados e riscos possuem cores semanticas consistentes.
- [ ] Hover e foco sao visiveis e discretos.
- [ ] Desktop, notebook e mobile foram revisados.
- [ ] Nao existe overflow horizontal indevido.
- [ ] A interface nao parece chatbot, planilha ou template generico.

## Prompt Pronto Para Aplicar Em Outro Sistema

```text
Quero aplicar ao sistema [NOME DO SISTEMA] uma identidade visual premium, sobria, institucional e operacional inspirada na linguagem visual LEX.OS.

Objetivo:
fazer o sistema parecer uma plataforma corporativa madura, utilizada diariamente por profissionais, com alta clareza, confianca, governanca e densidade controlada.

Direcao visual:
- fundo dark navy/ink com profundidade e brilhos radiais muito discretos;
- superficies em navy/panel com bordas sutis e sombras leves;
- dourado usado com moderacao para institucionalidade, item ativo e acoes importantes;
- cyan usado para tecnologia, informacao e elementos assistivos;
- silver/off-white para leitura;
- verde, vinho e vermelho somente para estados semanticos;
- estetica premium, calma, precisa e sem aparencia de template SaaS generico.

Tipografia:
- sans-serif moderna para interface e textos;
- serif elegante para titulos principais e numeros importantes;
- monoespacada para eyebrows, codigos, datas e metadados;
- titulos fortes, textos objetivos e boa legibilidade.

Layout:
- sidebar fixa no desktop e navegacao compacta no mobile;
- topbar sticky;
- container principal amplo, com largura maxima aproximada de 1500px;
- paineis internos alinhados a largura util normal da pagina;
- grids responsivos;
- cards compactos, proporcionais e com espacamento consistente;
- evitar espacos vazios excessivos e conteudo centralizado sem necessidade.

Componentes:
- cards com radius entre 12px e 16px, bordas discretas e padding entre 16px e 24px;
- badges em formato pill, sem sobreposicao, com altura minima de 28px;
- botoes primarios dourados e secundarios navy;
- listas operacionais em grid no desktop e cards verticais no mobile;
- cabecalhos com eyebrow mono, titulo serif e descricao curta;
- avisos institucionais com fundo sutil e icone;
- estados disabled claros;
- hover, foco visivel e feedback de acao.

Responsividade:
- desktop amplo aproveitando a largura util;
- reducao progressiva de colunas em notebook;
- uma coluna no mobile;
- tabelas convertidas em cards verticais;
- nenhum overflow horizontal;
- badges, textos e botoes nunca podem se sobrepor.

Evitar:
- visual de chatbot;
- dashboard SaaS generico;
- cards gigantes;
- excesso de glow, neon, blur ou gradientes chamativos;
- cores sem funcao;
- paineis estreitos centralizados;
- layout desktop apenas comprimido no mobile;
- alteracoes de logica ou funcionamento sem autorizacao.

Antes de finalizar:
revise hierarquia, espacamentos, alinhamentos, contraste, consistencia entre telas, responsividade, hover, foco e overflow. Preserve o conteudo e a identidade propria do projeto [NOME DO SISTEMA], aplicando somente a linguagem visual descrita.
```

## Referencia De Implementacao

No Cartorio Control, os tokens principais estao em:

- `src/app/globals.css`;
- `tailwind.config.ts`.

Os padroes de componentes podem ser observados em:

- `src/components/app-shell.tsx`;
- `src/components/ui.tsx`;
- `src/components/lists.tsx`;
- `src/components/workflow.tsx`.

O guia deve ser adaptado ao dominio e conteudo de cada novo sistema. A linguagem visual pode ser compartilhada; a arquitetura, os textos e as funcionalidades nao devem ser copiados automaticamente.
