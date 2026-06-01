import SwiftUI
import SwiftData

struct DocenteFormView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var docente: Docente
    var esNuevo: Bool

    var body: some View {
        Form {
            Section("INFORMACIÓN PERSONAL") {
                TextField("Nombres", text: $docente.firstName)
                TextField("Apellidos", text: $docente.lastName)
                TextField("Apellido paterno", text: $docente.apellidoPaterno)
                TextField("Correo", text: $docente.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                TextField("Teléfono", text: $docente.phone)
                    .keyboardType(.phonePad)
                DatePicker("Fecha de nacimiento", selection: $docente.dateOfBirth, displayedComponents: .date)
            }

            Section("INFORMACIÓN PROFESIONAL") {
                TextField("Cargo / Título", text: $docente.positionTitle)
                DatePicker("Fecha de contratación", selection: $docente.hireDate, displayedComponents: .date)
                Toggle("Activo", isOn: $docente.isActive)
            }

            if !esNuevo {
                Section {
                    Button("Eliminar docente", role: .destructive) {
                        modelContext.delete(docente)
                        try? modelContext.save()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle(esNuevo ? "Agregar docente" : "Editar docente")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Guardar") { guardar() }
                    .disabled(!formularioValido)
            }
        }
    }

    private var formularioValido: Bool {
        !docente.firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !docente.lastName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !docente.email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !docente.phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !docente.positionTitle.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func guardar() {
        if esNuevo {
            modelContext.insert(docente)
        }
        try? modelContext.save()
        dismiss()
    }
}
