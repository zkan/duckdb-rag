workspace {

  !identifiers hierarchical

  model {
    biz_user = person "Biz User" {
      description "ผู้ใช้งานภาคธุรกิจที่จะดูข้อมูลเพื่อไปต่อยอดธุรกิจ"
    }

    duckdb_query_retriever = softwareSystem "DuckDB Query Retriever" {
      description "System that allows users to ask questions about their data"

      db = container "Database" {
        technology "DuckDB"
        description "Stores employee and purchase data"
        tags "Database"
      }

      app = container "DuckDB Query Retriever App" {
        technology "Streamlit"
        description "Web-based app that allows users to ask questions about their data"

        user_interface = component "User Interface" {
          technology "Streamlit Widget"
        }

        encoder = component "Encoder" {
          technology "Sentence Transformer"
        }

      }

      groq = container "Generative AI" {
        technology "Groq"
        description "Cloud-based, open-source AI platform for building, training, and deploying large-scale AI models"
      }

    }

    biz_user -> duckdb_query_retriever "Uses"
    biz_user -> duckdb_query_retriever.app "Uses"
    duckdb_query_retriever.app -> duckdb_query_retriever.db "Reads data from"
    duckdb_query_retriever.app -> duckdb_query_retriever.groq "Gets summarization"
    biz_user -> duckdb_query_retriever.app.user_interface "Writes a question/additional summarization context"
    duckdb_query_retriever.app.user_interface -> duckdb_query_retriever.app.encoder "Sends text to encode"
    duckdb_query_retriever.app.user_interface -> duckdb_query_retriever.groq "Sends a chat message and gets summarization"
    duckdb_query_retriever.app.user_interface -> duckdb_query_retriever.db "Reads data from"
  }

  views {
    systemContext duckdb_query_retriever "SystemContext" {
      include *
      autoLayout lr
      description "The system context diagram for the DuckDB Query Retriever"
    }

    container duckdb_query_retriever "Container" {
      include *
      autolayout lr
    }

    component duckdb_query_retriever.app "Component" {
      include *
      autolayout lr
    }

    theme default

    styles {
      element "Database" {
        shape cylinder
      }
    }
  }

}
