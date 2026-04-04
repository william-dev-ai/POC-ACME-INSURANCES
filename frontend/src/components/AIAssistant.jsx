import { useState, useRef, useEffect } from 'react'
import axios from 'axios'

const API = import.meta.env.VITE_API_URL || 'http://localhost:8000'

const DEMO_VRAGEN = [
  'Ik zie een piek bij IT in maart 2025, wat is er gebeurd?',
  'Welke kostensoort is verantwoordelijk?',
  'Welke facturen zijn daarvoor verantwoordelijk?',
  'Is dit normaal voor deze leverancier?',
  'Zijn er events geregistreerd die dit verklaren?',
  'Wat valt er op bij Marketing Wiley in februari 2026?',
]

export default function AIAssistant() {
  const [messages, setMessages] = useState([])
  const [input, setInput] = useState('')
  const [loading, setLoading] = useState(false)
  const [sessionId, setSessionId] = useState(null)
  const messagesEndRef = useRef(null)

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages, loading])

  const sendMessage = async (text) => {
    const vraag = text || input.trim()
    if (!vraag || loading) return

    setInput('')
    setMessages((prev) => [...prev, { role: 'user', text: vraag }])
    setLoading(true)

    try {
      const res = await axios.post(`${API}/api/chat`, {
        session_id: sessionId,
        question: vraag,
      })
      setSessionId(res.data.session_id)
      setMessages((prev) => [...prev, { role: 'assistant', text: res.data.answer }])
    } catch (err) {
      setMessages((prev) => [
        ...prev,
        { role: 'assistant', text: 'Er is een fout opgetreden. Controleer of de backend actief is.' },
      ])
    } finally {
      setLoading(false)
    }
  }

  const clearSession = async () => {
    if (sessionId) {
      try { await axios.delete(`${API}/api/chat/session/${sessionId}`) } catch {}
    }
    setMessages([])
    setSessionId(null)
  }

  const handleKeyDown = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault()
      sendMessage()
    }
  }

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 0 }}>
      <div className="ai-card">
        <div className="ai-header">
          <div className="ai-title">AI Assistent</div>
          {messages.length > 0 && (
            <button className="ai-clear-btn" onClick={clearSession}>
              Gesprek wissen
            </button>
          )}
        </div>

        <div className="ai-messages">
          {messages.length === 0 && (
            <div style={{ color: '#6e7781', fontSize: 13, textAlign: 'center', marginTop: 40 }}>
              <div style={{ fontSize: 24, marginBottom: 8 }}>💬</div>
              Stel een vraag over de bedrijfskosten.<br />
              <span style={{ fontSize: 11 }}>Gebruik de suggesties hieronder of typ je eigen vraag.</span>
            </div>
          )}

          {messages.map((msg, i) => (
            <div key={i} className={`message message-${msg.role}`}>
              <span className="message-label">
                {msg.role === 'user' ? 'Jij' : 'ACME AI'}
              </span>
              <div className="message-bubble">{msg.text}</div>
            </div>
          ))}

          {loading && (
            <div className="message message-assistant">
              <span className="message-label">ACME AI</span>
              <div className="typing-indicator">
                <div className="typing-dot" />
                <div className="typing-dot" />
                <div className="typing-dot" />
              </div>
            </div>
          )}
          <div ref={messagesEndRef} />
        </div>

        <div className="ai-input-area">
          <textarea
            className="ai-input"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={handleKeyDown}
            placeholder="Stel een vraag in het Nederlands..."
            disabled={loading}
            rows={1}
          />
          <button
            className="ai-send-btn"
            onClick={() => sendMessage()}
            disabled={loading || !input.trim()}
          >
            {loading ? '...' : 'Stuur'}
          </button>
        </div>
      </div>

      <div className="demo-hints" style={{ background: 'white', borderRadius: '0 0 8px 8px', border: '1px solid #e1e4e8', borderTop: 'none', padding: '10px 16px' }}>
        {DEMO_VRAGEN.map((v, i) => (
          <button key={i} className="demo-hint" onClick={() => sendMessage(v)}>
            {v}
          </button>
        ))}
      </div>
    </div>
  )
}
