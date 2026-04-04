export default function Findings({ text, loading }) {
  return (
    <div className="card" style={{ height: '100%' }}>
      <div className="card-title">Voorlopige Bevindingen</div>
      {loading ? (
        <p className="findings-loading">Analyse wordt gegenereerd...</p>
      ) : text ? (
        <p className="findings-text">{text}</p>
      ) : (
        <p className="findings-loading">Selecteer filters om een automatische toelichting te genereren.</p>
      )}
    </div>
  )
}
