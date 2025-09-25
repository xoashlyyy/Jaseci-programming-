# note_assistant_ai.jac

::py::
import uuid
from datetime import datetime

notes = []

def get_uuid():
    return str(uuid.uuid4())

def get_timestamp():
    return datetime.utcnow().isoformat()

def add_note(content, tags):
    note = {
        "id": get_uuid(),
        "content": content,
        "tags": tags,
        "created_at": get_timestamp(),
    }
    notes.append(note)
    return note

def list_notes():
    return notes
::py::

import from byllm.llm { Model }

# global LLM model instance
glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

# AI helper functions
def summarize_notes(note_list: list) -> str by llm();
def suggest_ideas(note_list: list) -> str by llm();

with entry {
    print("Note Assistant (AI Edition) ready!");

    let n1 = add_note("Research about Jac language integration with AI.", ["jac", "ai"]);
    let n2 = add_note("Plan weekend project: build a chatbot with memory.", ["project", "chatbot"]);

    print("Listing notes:");
    for n in list_notes() {
        print("[" + n["id"] + "] " + n["content"] + " (tags: " + ", ".join(n["tags"]) + ")");
    }

    # AI-powered actions
    let summary = summarize_notes(list_notes());
    print("AI Summary: " + summary);

    let ideas = suggest_ideas(list_notes());
    print("AI Suggestions: " + ideas);
}
