import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Docente.lastName) private var docentes: [Docente]

    @State private var buscar = ""
    @State private var mostrarAgregar = false
    @State private var docenteAEditar: Docente?

    private var lista: [Docente] {
        guard !buscar.isEmpty else { return docentes }
        return docentes.filter {
            $0.firstName.localizedCaseInsensitiveContains(buscar) ||
            $0.lastName.localizedCaseInsensitiveContains(buscar) ||
            $0.fullName.localizedCaseInsensitiveContains(buscar) ||
            $0.positionTitle.localizedCaseInsensitiveContains(buscar) ||
            $0.email.localizedCaseInsensitiveContains(buscar)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(lista) { docente in
                    Button { docenteAEditar = docente } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(docente.fullName).font(.headline)
                            Text(docente.positionTitle).font(.subheadline).foregroundStyle(.blue)
                            Text(docente.email).font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .onDelete { indices in
                    indices.forEach { modelContext.delete(lista[$0]) }
                    try? modelContext.save()
                }
            }
            .navigationTitle("Docentes")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $buscar, prompt: "Buscar docentes...")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { mostrarAgregar = true } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrarAgregar, onDismiss: { buscar = "" }) {
                NavigationStack {
                    DocenteFormView(docente: docenteVacio(), esNuevo: true)
                }
            }
            .sheet(item: $docenteAEditar, onDismiss: { buscar = "" }) { docente in
                NavigationStack {
                    DocenteFormView(docente: docente, esNuevo: false)
                }
            }
        }
    }

    private func docenteVacio() -> Docente {
        Docente(
            firstName: "", lastName: "", apellidoPaterno: "", email: "", phone: "",
            dateOfBirth: .now, positionTitle: "", hireDate: .now
        )
    }
}
